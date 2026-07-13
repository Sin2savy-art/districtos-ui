-- DistrictOS Migration V3
-- Adds grace period, renewal reminders, late fees, partial payments support

-- Add grace_end and renewal_warned columns to leases
ALTER TABLE leases ADD COLUMN grace_end INTEGER DEFAULT 0;
ALTER TABLE leases ADD COLUMN renewal_warned INTEGER DEFAULT 0;

-- Add 'grace' as a valid unit status (no schema change needed -- TEXT column)
-- Update any existing expired-but-should-be-grace leases (manual cleanup)

-- Add default settings for grace period and late fees
INSERT OR IGNORE INTO settings (key, value) VALUES ('grace_period_hours', '24');
INSERT OR IGNORE INTO settings (key, value) VALUES ('late_fee_amount', '0');

-- Verify
SELECT key, value FROM settings WHERE key IN ('grace_period_hours', 'late_fee_amount');
