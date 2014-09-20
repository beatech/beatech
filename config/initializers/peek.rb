if Rails.env.development?
  Peek.into Peek::Views::Rblineprof
  Peek.into Peek::Views::GC
  Peek.into Peek::Views::Mysql2
  Peek.into Peek::Views::PerformanceBar
end
