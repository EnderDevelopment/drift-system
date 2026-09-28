CREATE TABLE IF NOT EXISTS drift_points (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(60) NOT NULL,
    points INT DEFAULT 0,
    UNIQUE KEY (identifier)
);

INSERT INTO drift_points (identifier, points) VALUES ('default', 0) ON DUPLICATE KEY UPDATE points = points;