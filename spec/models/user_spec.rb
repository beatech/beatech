require "spec_helper"

describe User do
  describe ".year_by_grade" do
    context "given no repeated_year" do
      context "when it is in January, February or March" do
        before { Timecop.freeze(Time.local(2014, 1, 1)) }

        specify do
          expect(User.year_by_grade(0)).to eq(2014)
          expect(User.year_by_grade(1)).to eq(2013)
          expect(User.year_by_grade(2)).to eq(2012)
          expect(User.year_by_grade(3)).to eq(2011)
          expect(User.year_by_grade(4)).to eq(2010)
        end
      end

      context "otherwise" do
        before { Timecop.freeze(Time.local(2014, 4, 1)) }

        specify do
          expect(User.year_by_grade(1)).to eq(2014)
          expect(User.year_by_grade(2)).to eq(2013)
          expect(User.year_by_grade(3)).to eq(2012)
          expect(User.year_by_grade(4)).to eq(2011)
        end
      end
    end

    context "given repeated_year" do
      context "when it is in January, February or March" do
        before { Timecop.freeze(Time.local(2014, 1, 1)) }

        specify do
          expect(User.year_by_grade(1, 1)).to eq(2012)
          expect(User.year_by_grade(2, 1)).to eq(2011)
          expect(User.year_by_grade(3, 1)).to eq(2010)
          expect(User.year_by_grade(4, 1)).to eq(2009)
          expect(User.year_by_grade(1, 2)).to eq(2011)
          expect(User.year_by_grade(2, 2)).to eq(2010)
          expect(User.year_by_grade(3, 2)).to eq(2009)
          expect(User.year_by_grade(4, 2)).to eq(2008)
        end
      end

      context "otherwise" do
        before { Timecop.freeze(Time.local(2014, 4, 1)) }

        specify do
          expect(User.year_by_grade(1, 1)).to eq(2013)
          expect(User.year_by_grade(2, 1)).to eq(2012)
          expect(User.year_by_grade(3, 1)).to eq(2011)
          expect(User.year_by_grade(4, 1)).to eq(2010)
          expect(User.year_by_grade(1, 2)).to eq(2012)
          expect(User.year_by_grade(2, 2)).to eq(2011)
          expect(User.year_by_grade(3, 2)).to eq(2010)
          expect(User.year_by_grade(4, 2)).to eq(2009)
        end
      end
    end
  end

  describe ".grade_by_year" do
    context "given no repeated_year" do
      context "when it is in January, February or March" do
        before { Timecop.freeze(Time.local(2014, 1, 1)) }

        specify do
          expect(User.grade_by_year(2014)).to eq(0)
          expect(User.grade_by_year(2013)).to eq(1)
          expect(User.grade_by_year(2012)).to eq(2)
          expect(User.grade_by_year(2011)).to eq(3)
          expect(User.grade_by_year(2010)).to eq(4)
        end
      end

      context "otherwise" do
        before { Timecop.freeze(Time.local(2014, 4, 1)) }

        specify do
          expect(User.grade_by_year(2014)).to eq(1)
          expect(User.grade_by_year(2013)).to eq(2)
          expect(User.grade_by_year(2012)).to eq(3)
          expect(User.grade_by_year(2011)).to eq(4)
        end
      end
    end

    context "given repeated_year" do
      context "when it is in January, February or March" do
        before { Timecop.freeze(Time.local(2014, 1, 1)) }

        specify do
          expect(User.grade_by_year(2012, 1)).to eq(1)
          expect(User.grade_by_year(2011, 1)).to eq(2)
          expect(User.grade_by_year(2010, 1)).to eq(3)
          expect(User.grade_by_year(2009, 1)).to eq(4)
          expect(User.grade_by_year(2011, 2)).to eq(1)
          expect(User.grade_by_year(2010, 2)).to eq(2)
          expect(User.grade_by_year(2009, 2)).to eq(3)
          expect(User.grade_by_year(2008, 2)).to eq(4)
        end
      end

      context "otherwise" do
        before { Timecop.freeze(Time.local(2014, 4, 1)) }

        specify do
          expect(User.grade_by_year(2013, 1)).to eq(1)
          expect(User.grade_by_year(2012, 1)).to eq(2)
          expect(User.grade_by_year(2011, 1)).to eq(3)
          expect(User.grade_by_year(2010, 1)).to eq(4)
          expect(User.grade_by_year(2012, 2)).to eq(1)
          expect(User.grade_by_year(2011, 2)).to eq(2)
          expect(User.grade_by_year(2010, 2)).to eq(3)
          expect(User.grade_by_year(2009, 2)).to eq(4)
        end
      end
    end
  end

  describe ".authenticate" do
    let!(:user) do
      User.make!(username: "username", password: "password", password_confirmation: "password")
    end

    context "given valid username" do
      let(:username) { "username" }

      context "given valid password" do
        let(:password) { "password" }

        it "returns user" do
          expect(User.authenticate(username, password)).to eq(user)
        end
      end

      context "given invalid password" do
        let(:password) { "pass" }

        it "returns nil" do
          expect(User.authenticate(username, password)).to eq(nil)
        end
      end
    end

    context "given invalid username" do
      let(:username) { "user" }

      context "given valid password" do
        let(:password) { "password" }

        it "returns nil" do
          expect(User.authenticate(username, password)).to eq(nil)
        end
      end

      context "given invalid password" do
        let(:password) { "pass" }

        it "returns nil" do
          expect(User.authenticate(username, password)).to eq(nil)
        end
      end
    end
  end
end
