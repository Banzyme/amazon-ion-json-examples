# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.6-slim

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Install pip requirements
ADD jsion_cli/requirements.txt .
RUN python -m pip install -r requirements.txt

WORKDIR /app
ADD ./jsion_cli /app

# Switching to a non-root user, please refer to https://aka.ms/vscode-docker-python-user-rights
RUN useradd appuser && chown -R appuser /app
USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["python", "jsion.py", "-i", "test.txt", "-o", "out.json"]
