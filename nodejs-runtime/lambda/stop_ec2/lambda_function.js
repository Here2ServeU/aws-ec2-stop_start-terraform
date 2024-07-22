const AWS = require('aws-sdk');
const ec2 = new AWS.EC2();
const sns = new AWS.SNS();

exports.handler = async (event) => {
  const instanceIds = process.env.INSTANCE_IDS.split(',');
  const snsTopicArn = process.env.SNS_TOPIC_ARN;
  
  try {
    const data = await ec2.stopInstances({ InstanceIds: instanceIds }).promise();
    console.log('Success', data.StoppingInstances);
    await sns.publish({
      Message: `Successfully stopped instances: ${instanceIds}`,
      Subject: 'EC2 Instances Stopped',
      TopicArn: snsTopicArn
    }).promise();
  } catch (err) {
    console.error('Error', err);
    await sns.publish({
      Message: `Error stopping instances: ${err}`,
      Subject: 'EC2 Instances Stopping Error',
      TopicArn: snsTopicArn
    }).promise();
  }
};

