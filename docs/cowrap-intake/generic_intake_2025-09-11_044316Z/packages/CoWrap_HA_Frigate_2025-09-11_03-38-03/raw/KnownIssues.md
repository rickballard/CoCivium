# Known Issues & Mitigations

## 1) Frigate restarts with Coral USB (EdgeTPU)
- Symptom: Logs show `USB transfer error 2`, fatal abort, watchdog restarts detection.
- Mitigations:
  - Use **CPU detector** temporarily:
    ```yaml
    detectors:
      cpu1:
        type: cpu
    # coral:
    #   type: edgetpu
    #   device: usb
    ```
  - Plug Coral **directly** into a stable USB3 port or a **quality powered** USB3 hub using a **short cable**.
  - After moving it, re-enable `coral` and confirm logs show EdgeTPU delegate without USB errors.

## 2) Reolink `no frames received` (e.g., Front Rental)
- Causes:
  - Wrong RTSP credentials/IP/path **from the Frigate container’s perspective**.
  - Too many simultaneous RTSP connections (phone app open; each camera has limits).
  - Codec/profile mismatch; substream disabled.
- Steps:
  - Confirm **both** sub and main play in **VLC**:
    - `rtsp://admin:ReoRick2025..@<ip>:554/h264Preview_01_sub`
    - `rtsp://admin:ReoRick2025..@<ip>:554/h264Preview_01_main`
  - In Reolink app:
    - Ensure **RTSP ON**, port **554**.
    - **Fluent/substream ON**, codec **H.264**, FPS ~5, resolution ~640x360.
    - Close the Reolink app while Frigate connects.
  - In Frigate, reduce RTSP sessions temporarily:
    - Remove `roles: [record]` (leave only `detect`) for that camera to test.
  - Optional: re-stream via go2rtc to consolidate connections (advanced).

## 3) HA Safe Mode (Recovery)
- Common triggers:
  - Invalid `lovelace.dashboards` key (use **hyphens**, not underscores).
  - Putting Frigate's `detectors:`/`cameras:` into `configuration.yaml`.
- Fix: Correct the YAML, `ha core check`, then restart.
