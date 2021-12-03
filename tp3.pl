%=================================  REGRAS UTILITARIAS  =====================================

% Verifica se um elemento ou lista de elementos pertence a outra lista
sublist([P|R], L) :-
    append([_, [P|R], _], L).

sublist(T, L) :-
    append([_, [T], _], L).



% Escreve uma lista no console utilizando uma string ou uma lista de forma recursiva
msg_r([]).
msg_r([P|R]) :-
    write(P), write(' '), msg_r(R).
msg_r(M) :-
    write(M).

% Escreve uma mensagem usando (msg_r/1) que printa uma lista ou uma string
escreva(M) :-
    write(' '), msg_r(M), nl, nl.

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


% ====================== ITERAÇÃO COM O USUÁRIO =========================================


%  Prompt de entrada para o usuário
prompt(L) :-
    write('> '),
    read_line_to_codes(user_input, Cs),
    normalize_string(Cs, NCs),
    atom_codes(A, NCs),
    atomic_list_concat(L, ' ', A).

interagir() :-
    prompt(Frase),
    interprete(Frase,Resposta),
    responda(Resposta).

% =============================== INTERPRETADOR =================================

palavras([]) --> [].
palavras([P|R]) --> [P], palavras(R).

frase(eu_sonhei_com, Curinga1, Curinga2) --> palavras(Curinga1), [eu, sonhei, com], palavras(Curinga2).
frase(eu_lembro, Curinga1, Curinga2) --> palavras(Curinga1), [eu, lembro], palavras(Curinga2).
frase(voce_lembra, Curinga1, Curinga2) --> palavras(Curinga1), [voce, lembra], palavras(Curinga2).
frase(se, Curinga1, Curinga2) --> palavras(Curinga1), [se], palavras(Curinga2).
frase(eu_sonhei, Curinga1, Curinga2) --> palavras(Curinga1), [eu, sonhei], palavras(Curinga2).
frase(minha_mae, Curinga1, Curinga2) --> palavras(Curinga1), [minha, mae], palavras(Curinga2).
frase(eu_quero, Curinga1, Curinga2) --> palavras(Curinga1), [eu, quero], palavras(Curinga2).
frase(sao_como, Curinga1, Curinga2) --> palavras(Curinga1), [sao,como], palavras(Curinga2).
frase(e_como, Curinga1, Curinga2) --> palavras(Curinga1), [e, como], palavras(Curinga2).
frase(eu_era_afirmacao, Curinga1, Curinga2) --> palavras(Curinga1), [eu, era], palavras(Curinga2).
frase(eu_era_pergunta, Curinga1, Curinga2) --> palavras(Curinga1), [eu, era], palavras(Curinga2), [?].
frase(eu_sou_afirmacao, Curinga1, Curinga2) --> palavras(Curinga1), [eu, sou], palavras(Curinga2).
frase(eu_sou_pergunta, Curinga1, Curinga2) --> palavras(Curinga1), [eu, sou], palavras(Curinga2), [?].
frase(voce_e_pergunta, Curinga1, Curinga2) --> palavras(Curinga1), [voce,e], palavras(Curinga2), [?].
frase(voce_e, Curinga1, Curinga2) --> palavras(Curinga1), [voce,e], palavras(Curinga2).
frase(voce_era_pergunta, Curinga1, Curinga2) --> palavras(Curinga1), [voce, era], palavras(Curinga2), [?].
frase(eu_nao_posso, Curinga1, Curinga2) --> palavras(Curinga1), [eu, nao, posso], palavras(Curinga2).
frase(eu_sinto, Curinga1, Curinga2) --> palavras(Curinga1), [eu, sinto], palavras(Curinga2).
frase(porque_voce_nao, Curinga1, Curinga2) --> palavras(Curinga1), [porque,voce,nao], palavras(Curinga2).
frase(sao, Curinga1, Curinga2) --> palavras(Curinga1), [sao], palavras(Curinga2).


interprete(E, repertorio(eu_sonhei_com, Curinga1, Curinga2)) :- 
    frase(eu_sonhei_com, Curinga1,Curinga2, E, []).

interprete(E, repertorio(eu_sonhei_com, Curinga1, Curinga2)) :- 
    frase(eu_sonhei_com, Curinga1,Curinga2, E, []).

interprete(Frase, oi):-
     sublist([oi],Frase).
    
interprete(Frase, computador):-
     sublist([computador],Frase).
    
interprete(Frase, nome):-
     sublist([nome],Frase).
    
interprete(Frase, desculpe):-
     sublist([desculpe],Frase).
    
interprete(Frase, sonho):-
     sublist([sonho],Frase).
    
interprete(Frase, meu_pai):-
     sublist([meu,pai],Frase).
    
interprete(Frase, estou_feliz):-
     sublist([estou,feliz],Frase).
    
interprete(Frase, estou_triste):-
     sublist([estou,triste],Frase).
    
interprete(Frase, parece):-
     sublist([parece],Frase).
    
interprete(Frase, mesmo):-
     sublist([mesmo],Frase).
    
interprete(Frase, eu_sou_afirmacao):-
     sublist([eu,sou],Frase).
    
interprete(Frase, eu_sou_pergunta):-
     sublist([eu,sou,?],Frase).
    
interprete(Frase, sou):-
     sublist([sou],Frase).
    
interprete(Frase, por_causa):-
     sublist([por,causa],Frase).
    
interprete(Frase, eu_sentia):-
     sublist([eu,sentia],Frase).
    
interprete(Frase, sim):-
     sublist([sim],Frase).
    
interprete(Frase, nao):-
     sublist([nao],Frase).
    
interprete(Frase, alguem):-
     sublist([alguem],Frase).
    
interprete(Frase, todos):-
     sublist([todos],Frase).
    
interprete(Frase, sempre):-
     sublist([sempre],Frase).
    
interprete(Frase, o_que):-
     sublist([o,que],Frase).
    
interprete(Frase, talvez):-
     sublist([talvez],Frase).
    
interprete(Frase, bye):-
     sublist([bye],Frase).
    
interprete(_, _).
    
% =============================== RESPOSTAS =====================================


responda(oi):-
    random_member(RespostaEscolhida, ['Como vai você? Por favor, me fale do seu problema.']),
    escreva(RespostaEscolhida).

responda(computador):-
    random_member(RespostaEscolhida, ['Computadores te incomodam?','O que você acha sobre máquinas?','Porque você menciona computadores?','O que você acha que máquinas tem a ver com o seu problema?']),
    escreva(RespostaEscolhida).

responda(nome):-
    random_member(RespostaEscolhida, ['Não estou interessado em nomes']),
    escreva(RespostaEscolhida).

responda(desculpe):-
    random_member(RespostaEscolhida, ['Por favor, não se desculpe','Desculpas não são necessárias','Como você se sente quando se desculpa?']),
    escreva(RespostaEscolhida).

responda(repertorio(eu_lembro, _,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['Você normalmente lembra',Curinga2,'?'],
        ['Lembrar ',Curinga2,' traz alguma outra lembrança à sua mente?'],
        ['Que outras coisas você lembra?'],
        ['Porque você lembra ',Curinga2,' nesse momento?'],
        ['O que na situação atual faz você lembrar ',Curinga2,'?   ']
    ]),
    escreva(RespostaEscolhida).

 responda(repertorio(voce_lembra, _,Curinga2)):-
     random_member(RespostaEscolhida, [
        ['Você acha que eu me esqueceria',Curinga2,'?'],
        ['Porque você acha que eu deveria lembrar',Curinga2,'agora?'],
        ['E que tal ',Curinga2,'?'],
        ['Você mencionou',Curinga2,'?']
    ]),
    escreva(RespostaEscolhida).

 responda(repertorio(se, _,Curinga2)):-
     random_member(RespostaEscolhida, [
        ['Sério?'],
        ['De verdade? se',Curinga2,'?']
]),
    escreva(RespostaEscolhida).

 responda(repertorio(eu_sonhei, _,Curinga2)):-
     random_member(RespostaEscolhida, [
    ['Realmente?',Curinga2,'?'],
    ['Você já sonhou',Curinga2,'enquanto acordado?'],
    ['Você já havia sonhado ',Curinga2,' antes?']
]),
    escreva(RespostaEscolhida).

responda(repertorio(eu_sonhei_com, Curinga1,_)):-
    random_member(RespostaEscolhida, [ ['Como você se sente em relação a',Curinga1,'na verdade?'] ]),
    escreva(RespostaEscolhida).

responda(sonho):-
    random_member(RespostaEscolhida, ['O que este sonho sugere a você?','Você sonha com frequencia?','Que pessoas aparecem em seus sonhos?','Você não acha que sonhos tem algo a ver com o seu problema?']),
    escreva(RespostaEscolhida).

 responda(repertorio(minha_mae, _,Curinga2)):-
    random_member(RespostaEscolhida, [
    ['Quem mais na sua família',Curinga2,'?'],
    ['Fale-me mais sobre a sua família']
]),
    escreva(RespostaEscolhida).

responda(meu_pai):-
    random_member(RespostaEscolhida, ['Seu pai?','Ele influencia você fortemente?','O que mais vem à sua mente quando você pensa no seu pai?']),
    escreva(RespostaEscolhida).

 responda(repertorio(eu_quero, _,Curinga2)):-
    random_member(RespostaEscolhida, [
    ['Qual a importância de ter ',Curinga2,'?'],
    ['Porque você quer ',Curinga2,'?'],
    ['Acho que você terá', Curinga2, 'logo']
]),
    escreva(RespostaEscolhida).

responda(estou_feliz):-
    random_member(RespostaEscolhida, ['Eu tenho alguma influência nisso?','O que te faz feliz?','Você pode explicar o porque de feliz?']),
    escreva(RespostaEscolhida).

responda(estou_triste):-
    random_member(RespostaEscolhida, ['Sinto que você se sinta assim','Estou certo de que não é prazeroso estar assim']),
    escreva(RespostaEscolhida).

 responda(repertorio(sao_como, Curinga1,Curinga2)):-
    random_member(RespostaEscolhida, ['Que semelhança você vê entre ',Curinga1,' e ', Curinga2]),
    escreva(RespostaEscolhida).


responda(repertorio(e_como, Curinga1,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['De que forma ',Curinga1,' é como', Curinga2],
        ['Que semelhança você vê?'],
        ['Será que há realmente alguma coisa em comum?'],
        ['Como?']
    ]),
    escreva(RespostaEscolhida).

responda(parece):-
    random_member(RespostaEscolhida, ['De que forma?','Que similaridades há?']),
    escreva(RespostaEscolhida).

responda(mesmo):-
    random_member(RespostaEscolhida, ['Que outras conexões você observa?']),
    escreva(RespostaEscolhida).

responda(repertorio(eu_era_afirmacao, _,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['Você era realmente?'],
        ['Talvez eu soubesse que você fosse', Curinga2],
        ['Porque você está me dizendo que era', Curinga2,'agora?']
    ]),
    escreva(RespostaEscolhida).

responda(repertorio(eu_era_pergunta, _,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['E se você fosse ',Curinga2,'?'],
        ['Você acha que era ',Curinga2],
        ['E qual o siginificado de ser ',Curinga2]
    ]),
    escreva(RespostaEscolhida).

responda(repertorio(eu_sou_afirmacao, _,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['E como você é ',Curinga2],
        ['Você quer ser ',Curinga2,'?']
    ]),
    escreva(RespostaEscolhida).

responda(repertorio(eu_sou_pergunta, _,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['Você acredita que você seja ',Curinga2],
        ['Você gostaria de ser ',Curinga2],
        ['Você gostaria que eu dissesse que você é',Curinga2],
        ['E qual o siginificado de ser ',Curinga2]    
    ]),
    escreva(RespostaEscolhida).

responda(sou):-
    random_member(RespostaEscolhida, ['Porque você está dizendo \"SOU\"?','Nao entendi']),
    escreva(RespostaEscolhida).

responda(repertorio(voce_e_pergunta, _,Curinga2)):-
    random_member(RespostaEscolhida, [
    ['E qual o seu interesse em saber se sou',Curinga2,' ou não?'],
    ['Você iria preferir se eu não fosse',Curinga2],
    ['Talvez eu seja',Curinga2,' em suas fantasias']
    ]),
    escreva(RespostaEscolhida).

responda(repertorio(voce_e_afirmacao, _,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['O que faz você pensar que eu sou',Curinga2,'?']
    ]),
    escreva(RespostaEscolhida).

responda(por_causa):-
    random_member(RespostaEscolhida, ['Essa é a razão?','Que outras razões você acha que poderiam haver?','E isto explica tudo?']),
    escreva(RespostaEscolhida).

responda(repertorio(voce_era_pergunta, _,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['Talvez eu fosse ',Curinga2],
        ['O que você acha?'],
        ['E se eu fosse ',Curinga2]
    ]),
    escreva(RespostaEscolhida).

responda(repertorio(eu_nao_posso, _,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['Você sempre sente ',Curinga2,' ?']
    ]),
    escreva(RespostaEscolhida).

responda(repertorio(eu_sinto, _,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['Você',Curinga2,'?'],
        ['Você acredita que eu não',Curinga2,''],
        ['Talvez eu vá',Curinga2,' depois']
    ]),
    escreva(RespostaEscolhida).

responda(eu_sentia):-
    random_member(RespostaEscolhida, ['Que outras coisas você sente?']),
    escreva(RespostaEscolhida).

responda(repertorio(porque_você_nao, _,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['Você ',Curinga2,'?'],
        ['Você acredita que eu não',Curinga2],
        ['Talvez eu vá ',Curinga2,' depois']
    ]),
    escreva(RespostaEscolhida).

responda(sim):-
    random_member(RespostaEscolhida, ['Você parece uma pessoa bem positiva','Tem certeza?','Entendo']),
    escreva(RespostaEscolhida).

responda(nao):-
    random_member(RespostaEscolhida, ['Porque não?','Você está sendo um pouco negativo','Você diz não só pra ser negativo?']),
    escreva(RespostaEscolhida).

responda(alguem):-
    random_member(RespostaEscolhida, ['Você pode ser mais específico?']),
    escreva(RespostaEscolhida).

responda(todos):-
    random_member(RespostaEscolhida, ['Com certeza não todos','Pode pensar em alguém em particular?','Quem por exemplo?','Você está pensando em alguém em particular?']),
    escreva(RespostaEscolhida).

responda(sempre):-
    random_member(RespostaEscolhida, ['Você pode dar um exemplo específico','Quando?','Sobre o que você está pensando?','Realmente sempre?']),
    escreva(RespostaEscolhida).

responda(o_que):-
    random_member(RespostaEscolhida, ['Porque você pergunta?','Essa pergunta é interessante para você?','O que você quer saber de verdade?','O que você acha?','O que vem à sua mente quando pergunta isso?']),
    escreva(RespostaEscolhida).

responda(talvez):-
    random_member(RespostaEscolhida, ['Você não parece muito certo']),
    escreva(RespostaEscolhida).

responda(repertorio(sao, _,Curinga2)):-
    random_member(RespostaEscolhida, [
        ['Você acha que eles poderiam não ser ',Curinga2],
        ['Possivelmente eles são ',Curinga2]
    ]),
    escreva(RespostaEscolhida).

responda(bye):-
    random_member(RespostaEscolhida, ['tchau']),
    escreva(RespostaEscolhida).

responda(_):-
    random_member(RespostaEscolhida, ['Muito interessante.,','Não sei se entendi você direito','O que isso sugere a você?','Por favor, continue.','Continue','Você quer mesmo falar sobre isso?','Elabore melhor']),
    escreva(RespostaEscolhida).
