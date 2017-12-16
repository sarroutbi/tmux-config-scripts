#!/usr/bin/env python
"""
Program to test Monty Hall paradigm
Usage:
${0} [-c: change user] [-d: number of doors, 3 by default] [-i: number of iterations, 1000 by default]
"""
import argparse
import random
from enum import Enum

DEFAULT_DOORS_AMOUNT=3
DEFAULT_CHANGE=0
DEFAULT_ITERATIONS=10000

def str2bool(value):
  return value.lower() in ("yes", "true", "t", "1")

class DOOR_CONTENT(Enum):
  GOAT  = 1
  CAR   = 2
  NONE = 3

class Result(object):
  """
  Representation of a result
  
  Attributes:
  - selected (door selected by user)
  - content (goat/cat)
  """
  def __init__(self):
    self.win = 0
    self.loose = 0
  def __str__(self):
    return str("-----------------------------" + "\n"
               "Wins:"   + str(self.win) + " " +
               "Looses:" + str(self.loose) + "\n" +
               "-----------------------------")
  def add_win(self):
    self.win += 1
  def add_loose(self):
    self.loose += 1

class Door(object):
  """
  Representation of a door

  Attributes:
  - selected (door selected by user)
  - content (goat/cat)
  - opened
  """
  def __init__(self, content_type = DOOR_CONTENT.NONE):
    self.content = content_type
    self.selected = False
    self.opened = False
  def is_winning_door(self):
    return self.selected and DOOR_CONTENT.CAR == self.content
  def open(self):
    self.open = True
  def __str__(self):
    return "[%s]" % ("G" if self.content == DOOR_CONTENT.GOAT
                     else "C")

def user_wins(doors):
  for door in doors:
    if door.is_winning_door():
      return True

def create_doors(args):
  doors = []
  car_position = random.randint(0, args.d-1)
  for x in range(0, args.d):
    if car_position == x:
      door = Door(DOOR_CONTENT.CAR)
    else:
      door = Door(DOOR_CONTENT.GOAT)
    doors.append(door)
  return doors

def open_goat_door(args, doors):
  for x in range(0, len(doors)):
    if doors[x].content == DOOR_CONTENT.GOAT:
      doors[x].open()
      return doors

def user_selects_door(doors):
  user_selection = random.randint(0, len(doors)-1)
  doors[user_selection].selected = True

def change_user_selection(doors):
  while True:
    selection = random.randint(0, len(doors)-1)
    for door_number in range(0, len(doors)):
      if door_number == selection and not doors[door_number].opened and not doors[door_number].selected:
        doors[door_number].selected = True
        return True

def parse_args():
  parser = argparse.ArgumentParser('%(prog) file to test Monty Hall paradigm')
  parser.add_argument('-d', help='number of doors', type=int, default=DEFAULT_DOORS_AMOUNT)
  parser.add_argument('-i', help='number of iterations (times to play)', type=int, default=DEFAULT_ITERATIONS)
  parser.add_argument('-c', help='specify just in case that user changes the door', type=int, default=DEFAULT_CHANGE)
  return parser.parse_args()

def calculate_results(args, doors, results):
  open_goat_door(args, doors)
  if args.c == 1:
      change_user_selection(doors)
  if user_wins(doors):
    results.add_win()
  else:
    results.add_loose()

def iterations(args):
  result = Result()

  # For each iteration (number of iteration is a parameter)
  for iteration in range(0, args.i):
    # Create the doors (number of doors is other parameter)
    doors = create_doors(args)
    # User selects door randomly, and changes door or not (door change is a parameter)
    user_selects_door(doors)
    # Calculate and store result
    calculate_results(args, doors, result)
    # end iterations
  print result
    
def main():
    iterations(parse_args())

if __name__ == "__main__":
    main()
