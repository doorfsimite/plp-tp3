% ===================================TRATAMENTO DE ENTRADA====================================

% Caso base de recursão
normalize_string([], []).

% Adiciona espaço antes de interrogações
normalize_string([63|R], [32,63|NR]) :-
    normalize_string(R, NR).

% remove caracteres especiais e espaços em brancos caso existam
normalize_string([32,Char|T], NR) :-
    Char > 32,
    Char < 48,
    normalize_string(T, NR).

% Caso não exista espaços em branco remove apenas os caracteres especiais
normalize_string([Char|T], NR) :-
    Char > 32,
    Char < 48,
    normalize_string(T, NR).

% Transforma letras maiúsculas em maiúsculas
normalize_string([Char|T], NR) :-
    to_lower(Char, CharLowerCase), % transforma a letra em lowercase
    Char \= CharLowerCase,         % Verifica se a letra era maiusula anteriormente
    normalize_string([CharLowerCase|T], NR). % Se não estava, faz a chamada da função novamente com ela atualizada

% Remove espaços em branco no final da frase caso existam
normalize_string([32], NR) :-
    normalize_string([], NR).

% Valida cada caractere de acordo com as demais definições de (normalize_string/2)
normalize_string([H|R], [H|NR]) :-
    normalize_string(R, NR).


prompt(L) :-
    write('> '),
    read_line_to_codes(user_input, Cs),
    normalize_string(Cs, NCs),
    atom_codes(A, NCs),
    atomic_list_concat(L, ' ', A).



% ======================== Identificação de semântica da entrada ========================

sublist([P|R], L) :-
    append([_, [P|R], _], L).

sublist(T, L) :-
    append([_, [T], _], L).

% =============================== RESPOSTAS =====================================
random_member(MeuPai, ['Seu pai?',
'Ele influencia você fortemente?',
'O que mais vem à mente quando você pensa no seu pai?'])