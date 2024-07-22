region         = "us-east-1"
instance_ids   = ["i-0893155f79ba1369c", "i-0985f2b44573c44e8"]
start_schedule = "cron(2 5 * * ? *)" # 12:02 AM CT (05:02 AM UTC)
stop_schedule  = "cron(7 5 * * ? *)" # 12:07 AM CT (05:07 AM UTC)
