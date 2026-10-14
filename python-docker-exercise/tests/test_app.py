import pytest
import sys
import os

# Ensure parent directory is in python path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home_endpoint(client):
    """Test standard home page endpoint returns 200 and expected greeting."""
    response = client.get('/')
    assert response.status_code == 200
    assert b"Hello from Dockerized Python" in response.data

def test_health_endpoint(client):
    """Test healthcheck endpoint returns JSON with healthy status."""
    response = client.get('/health')
    assert response.status_code == 200
    json_data = response.get_json()
    assert json_data["status"] == "healthy"
    assert "uptime_seconds" in json_data
    assert json_data["service"] == "python-docker-exercise"

def test_api_info_endpoint(client):
    """Test metadata info endpoint returns service information."""
    response = client.get('/api/info')
    assert response.status_code == 200
    json_data = response.get_json()
    assert "version" in json_data
    assert "python_version" in json_data