region         = "us-east-1"
instance_ids   = ["i-0123456789abcdef0", "i-0abcdef1234567890"]
start_schedule = "cron(27 22 * * ? *)"  # 5:27 PM CT (11:27 PM UTC)
stop_schedule  = "cron(45 0 * * ? *)"   # 7:45 PM CT (12:45 AM UTC)
