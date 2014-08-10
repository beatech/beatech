# coding: utf-8
module ApplicationHelper
  def link_to_entry(entry)
    label =
      if entry.url == 'frontpage'
        'トップページ'
      else
        entry.title
      end

    if /^https?:\/\// =~ entry.url
      link_to(label, entry.url)
    else
      link_to(label, File.join(root_url, entry.url))
    end
  end

  def entry_link(title, url)
    title = 'トップページ' if url == 'frontpage'
    if /^http:\/\// =~ url
      link_to(title, url)
    else
      link_to(title, root_url + url)
    end
  end

  def tabs(text)
    if text
      if text =~/&tab\(.+\)/
        $&.gsub(/^&tab\(/, '').gsub(/\)/, '').strip.split(',')
      else
        nil
      end
    else
      nil
    end
  end

  def pop_latest_date_entries
    latest_date = @recent_entries.first.updated_at.to_date
    latest_date_entries = Array.new
    rest_entries = Array.new
    @recent_entries.each do |entry|
      if entry.updated_at.to_date == latest_date
        latest_date_entries << entry
      else
        rest_entries << entry
      end
    end
    @recent_entries = rest_entries
    { date: latest_date, entries: latest_date_entries }
  end
end
