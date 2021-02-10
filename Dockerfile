FROM recksahr/sony_workflow_containers:latest

COPY entrypoint.sh /entrypoint.sh
COPY rosbag_health_checker.py /rosbag_health_checker.py

ENTRYPOINT ["/entrypoint.sh"]