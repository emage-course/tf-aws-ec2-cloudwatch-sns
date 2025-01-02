To create a Slack webhook for integrating notifications from
AWS SNS (or other sources), follow these steps:

---

**Step 1: Set Up a Slack App**

1. **Go
   to the Slack API page:**

   Visit the Slack API Apps page.
2. **Create
   a new app:**

   * Click  **"Create
     an App"** .
   * Choose  **"From
     Scratch"** .
   * Enter
     an **App Name** (e.g., "AWS Notifications") and
     select the workspace where you want the app to live.

---

**Step 2: Add Incoming Webhooks**

1. **Navigate
   to Features:**

   On your app's settings page, go to the **"Incoming
   Webhooks"** section in the left-hand menu.
2. **Activate
   Webhooks:**

   Toggle the **Activate Incoming Webhooks** switch to
   "On."
3. **Create
   a Webhook URL:**

   * Scroll
     down and click  **"Add New Webhook to Workspace"** .
   * Choose
     the Slack channel where you want to post messages.
   * Click **"Allow"** to
     grant the app permission to post to the channel.
4. **Copy
   the Webhook URL:**

   After creation, Slack will provide a unique Webhook URL (e.g., https://hooks.slack.com/services/XXXXX/XXXXX/XXXXX).
   Save this URL for use in your configuration.

---

**Step 3: Configure the Webhook in Your Terraform or System**


########################################################################################################
# SNS Topic Subscription for Slack
########################################################################################################

resource "aws_sns_topic_subscription" "topic_slack_subscription" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "https"
  endpoint  = var.slack_webhook_url

  filter_policy = jsonencode({
    EventType = ["ALERT", "NOTIFICATION"]
  })

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-slack-subscription"
  })
}
