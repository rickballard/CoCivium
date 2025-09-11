# Workflows (Commands & Where Things Live)

## HA / Supervisor CLI
- List add-ons and find Frigate slug:
  ```bash
  ha addons list | grep -i frigate
  ```
- Show add-on logs:
  ```bash
  ha addons logs ccab4aaf_frigate --lines 400
  ```
- Restart add-on:
  ```bash
  ha addons restart ccab4aaf_frigate
  ```
- Validate HA config & restart core:
  ```bash
  ha core check
  ha core restart
  ```

## Frigate config locations (HA add-on)
- **Live config (source of truth):** `/addon_configs/ccab4aaf_frigate/config.yml`
  - The Frigate Web UI **Configuration Editor** writes to this file.
- **Do NOT use** Add-on → Options YAML for Frigate config (keep it empty).
- **Do NOT use** `/config/frigate/config.yml` for the HA add-on (only for docker/manual installs).

## Lovelace dashboards
- In `configuration.yaml`:
  ```yaml
  lovelace:
    dashboards:
      home-plus-cameras:
        mode: yaml
        title: Home + Cameras
        show_in_sidebar: true
        icon: mdi:cctv
        filename: dashboards/home_control_plus_cameras.yaml
  ```
- Dashboard file must start with `title:` and `views:` — not `dashboards:`.

## Motion popups (Browser Mod)
- Requires HACS → install **browser_mod**.
- Automations live in `automations.yaml` or as included package; sample is in `AUTOMATIONS/motion_popups.yaml`.
- Sensors with 15s "hold" live in `configuration.yaml` (template binary_sensors) or an include:
  ```yaml
  template:
    - binary_sensor:
        - name: "Driveway Motion (hold)"
          unique_id: driveway_motion_hold
          state: "{{ is_state('binary_sensor.driveway_motion','on') }}"
          delay_off: "00:00:15"
        # repeat for other cameras...
  ```
