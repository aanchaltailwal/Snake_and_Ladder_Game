#!/bin/bash

# Function to print the current board
function print_board {
  echo "----------------------------------"
  echo "| 100| 99 | 98 | 97 | 96 | 95 | 94 | 93 | 92 | 91 |"
  echo "|----|----|----|----|----|----|----|----|----|----|"
  echo "| 81 | 82 | 83 | 84 | 85 | 86 | 87 | 88 | 89 | 90 |"
  echo "|----|----|----|----|----|----|----|----|----|----|"
  echo "| 80 | 79 | 78 | 77 | 76 | 75 | 74 | 73 | 72 | 71 |"
  echo "|----|----|----|----|----|----|----|----|----|----|"
  echo "| 61 | 62 | 63 | 64 | 65 | 66 | 67 | 68 | 69 | 70 |"
  echo "|----|----|----|----|----|----|----|----|----|----|"
  echo "| 60 | 59 | 58 | 57 | 56 | 55 | 54 | 53 | 52 | 51 |"
  echo "|----|----|----|----|----|----|----|----|----|----|"
  echo "| 41 | 42 | 43 | 44 | 45 | 46 | 47 | 48 | 49 | 50 |"
  echo "|----|----|----|----|----|----|----|----|----|----|"
  echo "| 40 | 39 | 38 | 37 | 36 | 35 | 34 | 33 | 32 | 31 |"
  echo "|----|----|----|----|----|----|----|----|----|----|"
  echo "| 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30 |"
  echo "|----|----|----|----|----|----|----|----|----|----|"
  echo "| 20 | 19 | 18 | 17 | 16 | 15 | 14 | 13 | 12 | 11 |"
  echo "|----|----|----|----|----|----|----|----|----|----|"
  echo "| 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |"
  echo "----------------------------------"
}

# Function to initialize the game
function initialize_game {
  player1_position=1
  player2_position=1
  player1_name="Player 1"
  player2_name="Player 2"
}

# Function to roll the dice
function roll_dice {
  echo $((RANDOM % 6 + 1))
}

# Function to check for snakes and ladders
function check_snakes_and_ladders {
  local position=$1
  case $position in
    4)  echo 14;; 9)  echo 31;; 17) echo 7;;
    20) echo 38;; 28) echo 84;; 40) echo 59;;
    51) echo 67;; 63) echo 81;; 64) echo 60;;
    89) echo 26;; 95) echo 75;; 99) echo 78;;
    *)  echo $position;;
  esac
}

# Function to move the player's token
function move_player {
  local player=$1
  local dice=$2
  local current_position=$3
  local new_position=$((current_position + dice))
  local updated_position=$(check_snakes_and_ladders $new_position)
  
  if [ $updated_position -le 100 ]; then
    if [ $player == "player1" ]; then
      player1_position=$updated_position
    else
      player2_position=$updated_position
    fi
    echo "$player moves $dice steps to position $updated_position."
  else
    echo "$player stays at position $current_position."
  fi
}

# Function to check if a player wins
function check_win {
  local player=$1
  local position=$2
  
  if [ $position -eq 100 ]; then
    echo "$player wins!"
    exit 0
  fi
}

# Main game loop
function main {
  initialize_game
  while true; do
    print_board
    echo "----------------------------------"
    echo -e "$player1_name is at position $player1_position\n$player2_name is at position $player2_position"
    echo -e "----------------------------------"
    
    # Player 1's turn
    player="player1"
    echo -e "$player1_name's turn. Press Enter to roll the dice."
    read
    dice=$(roll_dice)
    echo "$player1_name rolls the dice and gets $dice."
    move_player $player $dice $player1_position
    check_win $player1_name $player1_position
    
    # Player 2's turn
    player="player2"
    echo -e "$player2_name's turn. Press Enter to roll the dice."
    read
    dice=$(roll_dice)
    echo "$player2_name rolls the dice and gets $dice."
    move_player $player $dice $player2_position
    check_win $player2_name $player2_position
  done
}

# Start the game
main

