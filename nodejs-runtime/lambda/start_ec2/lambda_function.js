const AWS = require('aws-sdk');
const ec2 = new AWS.EC2();
const sns = new AWS.SNS();

exports.handler = async (event) => {
  const instanceIds = process.env.INSTANCE_IDS.split(',');
  const snsTopicArn = process.env.SNS_TOPIC_ARN;
  
  try {
    const data = await ec2.startInstances({ InstanceIds: instanceIds }).promise();
    console.log('Success', data.StartingInstances);
    await sns.publish({
      Message: `Successfully started instances: ${instanceIds}`,
      Subject: 'EC2 Instances Started',
      TopicArn: snsTopicArn
    }).promise();
  } catch (err) {
    console.error('Error', err);
    await sns.publish({
      Message: `Error starting instances: ${err}`,
      Subject: 'EC2 Instances Starting Error',
      TopicArn: snsTopicArn
    }).promise();
  }
};
