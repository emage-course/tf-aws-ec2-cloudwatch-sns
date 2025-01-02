# Linux Web Server in AWS using Terraform with a cloudwatch alarm and SNS for email alert.

Deploying Linux Web Server EC2 Instance in AWS using Terraform with a cloudwatch alarm and SNS for email alert

![Alt text](images/diagram.png)

1. vpc module - to create vpc, public subnets, internet gateway, security groups and route tables
2. web module - to create Linux Web EC2 instances with userdata script to display instance metadata using latest Amazon Linux ami in multiple subnets created in vpc module
3. main module - Above modules get called in main config. Create a SNS topic, its subscription and cloudwatch alarm metric

In variables.tf, on line 72, change the default email address to your email address.

```sh
variable "email_address" {
  type        = list(string)
  description = "List of email addresses to receive email alerts"
  default     = ["jdoe@gmail.com"]
}
```

# Other notes

1. Metric somtimes goes to "INSUFFICIENT_DATA" state because of multiple reasons. Refer to https://repost.aws/knowledge-center/cloudwatch-alarm-insufficient-data-state

Missing monitoring data is treated as good using "treat_missing_data" param

2. For explanation purpose, detailed monitoring is enabled for EC2 instances for monitoring every 1 minute using "monitoring" param. This will incur more charges.

Terraform Apply Output:

```
Apply complete! Resources: 14 added, 0 changed, 0 destroyed.

Outputs:

ec2_instance_ids = [
  "i-0000000000000000",
  "i-0000000000000000",
]
public_subnets = [
  "subnet-0000000000000000",
  "subnet-0000000000000000",
]
security_groups_ec2 = [
  "sg-0000000000000000",
]
```

SNS topic created:

![Alt text](images/snstopic.png)

Subscription confirmation:

![Alt text](images/sub1.png)

![Alt text](images/sub2.png)

Running EC2 instances:

![Alt text](images/ec2list.png)

Cloudwatch Alarms:

![Alt text](images/cwalarm1.png)

![Alt text](images/cwalarm2.png)

Stressing first EC2:
We need to install stress package:

```
 amazon-linux-extras install epel -y
 yum install stress -y
 stress -c 1 --backoff 300000000 -t 30m
```

![Alt text](images/stressa1.png)

![Alt text](images/stressa2.png)

![Alt text](images/stressa3.png)

Stressing second EC2:

![Alt text](images/stressb1.png)

![Alt text](images/stressb2.png)

![Alt text](images/stressb3.png)

Both instances in alarm state:

![Alt text](images/alarm1.png)

![Alt text](images/alarm2.png)

### 1. List SNS Topics

aws sns list-topics

### 2. List Subscriptions

aws sns list-subscriptions
aws sns list-subscriptions-by-topic --topic-arn `<TopicArn>`
aws sns list-topics

### List Subscriptions for a Specific Topic:

aws sns list-subscriptions-by-topic --topic-arn arn:aws:sns:us-east-1:123456789012:my-topic

### After deploying your Terraform configuration, it's essential to verify the status of the email subscription you've configured. Here's how you can proceed:

1. **Check Your Email Inbox:**
   * Terraform can create an Amazon Simple Notification Service (SNS) topic and an email subscription. After deployment, you should receive a confirmation email from AWS SNS. Open this email and click the confirmation link to activate the subscription.** **[Stack Overflow](https://stackoverflow.com/questions/67348642/can-we-add-an-sns-topic-from-terraform-with-email-subscription?utm_source=chatgpt.com)
2. **Verify Subscription Status in AWS Console:**
   * Log in to the** **[AWS** **Management** **Console](https://aws.amazon.com/console/).
   * Navigate to the** ****SNS** service.
   * Select the** ****Topics** section and choose the topic you created.
   * Under the** ****Subscriptions** tab, confirm that your email address appears with a status of** ** **Confirmed** .
3. **Troubleshoot Subscription Issues:**
   * If you haven't received the confirmation email, check your spam or junk folder.
   * Ensure that the email address used in your Terraform configuration is correct and accessible.
   * If the subscription status remains** ** **PendingConfirmation** , resend the confirmation email from the AWS SNS console.
