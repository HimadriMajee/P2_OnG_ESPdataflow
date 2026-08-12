CREATE TABLE IF NOT EXISTS maintenance_work_orders (
    work_order_id     SERIAL PRIMARY KEY,
    well_id            VARCHAR(20) NOT NULL,
    work_order_type    VARCHAR(20) NOT NULL
                        CHECK (work_order_type IN ('inspection','repair','replacement','workover')),
    status             VARCHAR(20) NOT NULL DEFAULT 'open'
                        CHECK (status IN ('open','in_progress','closed')),
    technician         VARCHAR(100),
    downtime_hours     NUMERIC(6,2) DEFAULT 0,
    notes              TEXT,
    created_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE maintenance_work_orders REPLICA IDENTITY FULL;

INSERT INTO maintenance_work_orders (well_id, work_order_type, status, technician, downtime_hours, notes)
VALUES
    ('WELL-001', 'inspection', 'closed', 'J. Alvarez', 0,   'Routine quarterly inspection, no issues found'),
    ('WELL-007', 'repair',     'open',   'M. Chen',    4.5, 'Vibration alarm triggered, investigating bearing wear');
