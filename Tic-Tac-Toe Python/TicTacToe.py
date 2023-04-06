import random

grid = [
    ["  1" , " 2" , " 3"], #0
    ["A"," -" , "|", "-" , "|", "-",], #1
    ["--------"], #2
    ["B", " -" , "|", "-" , "|", "-",], #3
    ["--------"], #4
    ["C", " -" , "|", "-" , "|", "-",] #5
    ]


def print_board(t):
    for i in range(len(t)):
        print("".join([str(x) for x in grid[i]]))

columns = [1, 2, 3]
rows = ["a", "b", "c"]
locations = [
    (1, 1),
    (1, 3),
    (1, 5),
    (3, 1),
    (3, 3),
    (3, 5),
    (5, 1),
    (5, 3),
    (5, 5),
    ]
taken = [] #for ai to see what it cannot take
old_board = grid #to see if player sucessfully placed their mark 

""" for reference 
grid = [ 
    ["  1" , " 2" , " 3"], #0
    ["A"," -" p(1, 1) , "|", "-" p(1, 3) , "|", "-" p(1, 5),], #1
    ["--------"], #2
    ["B", " -"p(3, 1), "|", "-" p(3, 3), "|", "-" p(3, 5),], #3
    ["--------"], #4
    ["C", " -" p(5, 1) , "|", "-" p(5, 3), "|", "-" p(5, 5),] #5
    ]
"""

def check_winner():
    for i in range (1, 7, 2):
        if grid[i][1] == " X" and grid[i][3] == "X"  and grid[i][5] == "X": #winning across 
            return 1
    for j in range (1, 7, 2):
        if grid[1][j] == " X" and grid[3][j] == " X" and grid[5][j] ==  " X": #winning downward in first columns
            return 1
        if grid[1][j] == "X" and grid[3][j] == "X" and grid[5][j] ==  "X": #winning downward in other columns
            return 1
    if grid[1][1] == " X" and grid[3][3] == "X" and grid[5][5] == "X": #winning diagonal negative slope
        return 1
    if grid[5][1] == " X" and grid[3][3] == "X" and grid[1][5] == "X": #winning diagonal positve slope
        return 1
    #writing code to see if they lost gonna be the same but O in place of X 
    for i in range (1, 7, 2):
        if grid[i][1] == " O" and grid[i][3] == "O"  and grid[i][5] == "O": #losing across 
            return -1
    for j in range (1, 7, 2):
        if grid[1][j] == " O" and grid[3][j] == " O" and grid[5][j] ==  " O": #losing downward in first columns
            return -1
        if grid[1][j] == "O" and grid[3][j] == "O" and grid[5][j] ==  "O": #losing downward in other columns
            return -1
    if grid[1][1] == " O" and grid[3][3] == "O" and grid[5][5] == "O": #losing diagonal negative slope
        return -1
    if grid[5][1] == " O" and grid[3][3] == "O" and grid[1][5] == "O": #losing diagonal positve slope
        return -1


def check_input_x(r):
    try:
        p = int(r)
        if p in columns:
            return r
        else:
            print("Please input a number from 1 to 3")
            x = input("Which column?: ")
            x = check_input_x(x)
            return x 
    except:
        print("Please input a number from 1 to 3")
        x = input("Which column?: ")
        x = check_input_x(x)
        return x

def input_y_to_num(i): #for the placement function
    if i == "a":
        return 1
    elif i == "b":
        return 3
    elif i == "c":
        return 5
    
            
def check_input_y(r):
    try:
        r = r.lower()
        p = int(r)
        print("Please input 'A', 'B', or 'C'")
        y = input ("Which row?: ")
        check_input_y(y)
        return y
    except:
        if r in rows:
            return r
        else:
            print("Please input 'A', 'B', or 'C'")
            y = input ("Which row?: ")
            y = check_input_y(y)
            return y

        
def placement(a, b): #x is a and y is b, to place the player's X 
    b = input_y_to_num(b)
    if a == 1:
        if (b, a) in taken:
            print("That position is taken")
        else:
            actually_placing_it(a, b)
    elif a == 2:
        if (b, a + 1) in taken:
            print("That position is taken")
        else:
            actually_placing_it(a, b)
    elif a == 3:
        if (b, a + 2) in taken:
            print("That position is taken")
        else:
            actually_placing_it(a, b)
            
def actually_placing_it(a, b):
    if a == 1:
        grid[b][a] = " X"
        taken.append((b, a))
    elif a == 2:
        grid[b][a + 1] = "X"
        taken.append((b, a + 1,))
    elif a == 3:
        grid[b][a + 2] = "X"
        taken.append((b, a + 2))

def ai_placement(a, b):
    if b == 1:
        grid[a][b] = " O"
        taken.append((a, b))
    elif b == 3:
        grid[a][b] = "O"
        taken.append((a, b))
    elif b == 5:
        grid[a][b] = "O"
        taken.append((a, b))


def rando_spot():
    pick_spot = random.choice(locations)
    if pick_spot in taken:
        rando_spot()
    else:
        place_a = pick_spot[0]
        place_b = pick_spot[1]
        ai_placement(place_a, place_b)
    

print_board(grid)

while "-" in grid[1] or "-" in grid[3] or "-" in grid[5]:
    if check_winner() == 1:
        print("You Win!") 
        break
    elif check_winner() == -1:
        print("Try again!")
        break
    print("Player's turn")
    x = input("Which column?: ")
    x = check_input_x(x)
    y = input ("Which row?: ")
    y = check_input_y(y)
    placement(int(x), y)
    print_board(grid)
    if check_winner() == 1:
        print("You Win!") 
        break
    elif check_winner() == -1:
        print("Try again!")
        break
    print("The ai's turn")
    try:
        rando_spot()
    except:
        break
    print_board(grid)
    if check_winner() == 1:
        print("You Win!")
    elif check_winner() == -1:
        print("Try again!")
        break
        
if check_winner() == None:
    print("It's a tie...")


