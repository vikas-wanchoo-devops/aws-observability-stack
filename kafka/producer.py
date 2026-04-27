from kafka import KafkaProducer
producer = KafkaProducer(bootstrap_servers='localhost:9092')
producer.send('flask-logs', b'Test log message')
producer.flush()
