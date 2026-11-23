from fastapi.testclient import TestClient

from app.main import app


def test_health():
    r = TestClient(app).get("/api/health")
    assert r.status_code == 200
    assert r.json() == {"status": "ok"}


def test_moved_image_notice(client, monkeypatch):
    """Nur im Image unter dem alten Namen (#170): Umzugshinweis als erste Warnung."""
    assert all(w["code"] != "image_umgezogen" for w in client.get("/api/v1/status").json()["warnungen"])
    monkeypatch.setenv("BALKONAUT_UMZUG", "1")
    assert client.get("/api/v1/status").json()["warnungen"][0]["code"] == "image_umgezogen"
    assert "balkonaut-docker:latest" in client.get("/").text
