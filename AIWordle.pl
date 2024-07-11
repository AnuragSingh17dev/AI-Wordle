:- dynamic word/1.

% Acceptable words chosen to be the correct word
word('peach').
word('grape').
word('frogs').
word('drawn').
word('table').
word('theme').
word('clear').
word('press').
word('apple').
word('happy').
word('music').
word('dream').
word('beach').
word('light').
word('smile').
word('peace').
word('heart').
word('water').
word('green').
word('cloud').
word('chair').
word('dance').
word('sweet').
word('laugh').
word('magic').
word('shine').
word('faith').
word('grace').
word('honor').
word('brave').
word('trust').
word('happy').
word('dream').
word('peace').
word('smile').
word('light').
word('water').
word('green').
word('cloud').
word('chair').
word('dance').
word('sweet').
word('laugh').

% Main predicate
play_wordle :-
    random_word(Word),
    format("Guess the 5-letter word (you have 6 attempts): ~n", []),
    play(Word, 6).

% Randomly select a word
random_word(Word) :-
    findall(W, word(W), Words),
    random_member(Word, Words).

% Main game loop
play(Word, Attempts) :-
    Attempts > 0,
    read(Guess),
    check_guess(Guess, Word, Feedback),
    format("Feedback: ~s~n", [Feedback]),
    (   Feedback = 'O O O O O'
    ->  format("Congratulations! You guessed the word: ~s~n", [Word])
    ;   NewAttempts is Attempts - 1,
        format("Attempts left: ~d~n", [NewAttempts]),
        play(Word, NewAttempts)
    ).
play(_, 0) :-
    format("Sorry, you have run out of attempts because the word was not guessed.~n").

% Check the guess
check_guess(Guess, Word, Feedback) :-
    atom_chars(Guess, GuessChars),
    atom_chars(Word, WordChars),
    check_guess_chars(GuessChars, WordChars, WordChars, FeedbackChars),
    atomic_list_concat(FeedbackChars, ' ', Feedback).

check_guess_chars([], _, [], []).
check_guess_chars([GuessChar|GuessTail], WordChars, [WordChar|WordTail], [FeedbackChar|FeedbackTail]) :-
    (   =(GuessChar, WordChar)
    ->  FeedbackChar = 'O'
    ;   member(GuessChar, WordChars)
    ->  FeedbackChar = '*'
    ;   FeedbackChar = 'X'
    ),
    check_guess_chars(GuessTail, WordChars, WordTail, FeedbackTail).

% Start the game
:- initialization(play_wordle).
