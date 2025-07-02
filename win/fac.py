import pyautogui
import time
import keyboard
import random
import sys
import logging


logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.DEBUG)


def get_interval():
    return 60 * random.randint(3, 5) + random.random()


def fac():
    while True:
        try:
            x, y = pyautogui.position()
            pyautogui.moveTo(x + 10, y + 10)
            pyautogui.moveTo(x, y)
            for i in range(3):
                keyboard.press_and_release('ctrl')
            logger.info('fac-ed')
            time.sleep(get_interval())
        except KeyboardInterrupt:
            sys.exit('...adios...')


if __name__ == '__main__':
    fac()
