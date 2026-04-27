import boto3, json
from kafka import KafkaProducer

logs = boto3.client('logs', region_name='eu-north-1')
producer = KafkaProducer(bootstrap_servers='localhost:9092')

response = logs.filter_log_events(
    logGroupName='/ecs/assaabloy-app-task',
    limit=10
)

for event in response['events']:
    producer.send('flask-logs', json.dumps(event).encode('utf-8'))

producer.flush()
