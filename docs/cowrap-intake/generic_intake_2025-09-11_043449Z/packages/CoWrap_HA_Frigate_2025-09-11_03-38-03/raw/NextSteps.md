# Next Steps (Actionable)

1. **Stabilize Coral**: run CPU for now; move Coral to direct USB3 or quality powered hub; then re-enable `edgetpu` and confirm clean logs.
2. **Front Rental no-frames**: verify in VLC; temporarily drop the `record` role; ensure substream H.264; close phone app; re-test; then re-add recording.
3. **Finalize motion popups**: confirm `browser_mod` installed; import `AUTOMATIONS/motion_popups.yaml`; verify `*_motion_hold` sensors exist; trigger motion and confirm 15s auto-close.
4. **Cameras dashboard**: keep YAML dashboard `home-plus-cameras`; adjust entities to your actual names under Developer Tools → States.
5. **NAS storage (later)**: mount SMB share via HA **Mounts**; set Frigate `database.path` and `record` storage to `/media/frigate`; verify free space & retention policy.
6. **Tablet**: choose Android tablet + Fully Kiosk Browser; point to the Home dashboard; set screen-on + kiosk; use `browser_mod` `browser_id` to target that tablet only for popups.
