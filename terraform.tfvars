# Replace the variables with the desired values.
# For best security practices, do not push to GitHub or publish these values. 
# Input these variables into your environment using the export command. 

region         = "us-east-1"
instance_ids   = ["i-0897642019378643h", "i-0786454hrf623242p"]
email = "t2scloud@gmail.com"
start_schedule = "cron(2 5 * * ? *)" # 12:02 AM CT (05:02 AM UTC)
stop_schedule  = "cron(7 5 * * ? *)" # 12:07 AM CT (05:07 AM UTC)
