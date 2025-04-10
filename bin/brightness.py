import subprocess

COMMAND_CUR_BRIGHTNESS = "g"
COMMAND_MAX_BRIGHTNESS = "m"

def get_brightness(command):
    result = subprocess.run(
        ["brightnessctl", "-d", "intel_backlight", command],
        capture_output = True,
        text = True
    )
    if result.returncode != 0:
        raise Exception(f"Command failed: {result.stderr.strip()}")
    return int(result.stdout.strip())


def calculate_brightness():
    b_current = get_brightness(COMMAND_CUR_BRIGHTNESS)
    b_max = get_brightness(COMMAND_MAX_BRIGHTNESS)

    result = int(b_current / b_max * 100)
    return f"☀️: {result}%"

