module "patch_manager" {
  source  = "../"

  # Patches will be applied only on instances tagged InstanceOS: $PLATFORM
  
  install_schedule = "cron(0 0 0 ? 1/3 SUN#1 *)"
  scan_schedule = "cron(0 0 0 ? * SUN *)"
  platforms = [ # Really don't know, just added what i think the using right now.
    "AMAZON_LINUX_2",
    "WINDOWS",
    "UBUNTU",
  ]
  schedule_timezone = "America/Sao_Paulo"

  install_notification_configs = [{ # Create a new topic or use one existed?
        notification_arn    = "aws_sns_topic.example.arn"
        notification_events = ["All"]
        notification_type   = "Command"
      }]

  max_install_errors = 3
  max_install_concurrency = 10

  log_bucket = "BUCKET_LOGS" # Be created or we already have?
  tags       = { # Not sure to what tag put in here
    "resource-tag": "patch-manager-resource"
  }
}