function [] = aufgabe2_3(input)
symbols = unique(input);
repetitions = hist(double(input), double(symbols));

% Probability
prob = repetitions ./ sum(repetitions);
% Self-information
i = log2(1 ./ prob);
% Entropy
h = sum(prob .* i);

sh_dict = shannonfanodict(symbols, prob);
hf_dict = huffmandict(num2cell(symbols), prob);

seq = changem(double(input), 1:length(symbols), symbols);
arith_enc = arithenco(seq, repetitions);
shannon_enc = huffmanenco(double(input), sh_dict);
huffman_enc = huffmanenco(double(input), hf_dict);
arith_dec = arithdeco(arith_enc, repetitions, length(seq));
shannon_dec = huffmandeco(shannon_enc, sh_dict);
huffman_dec = huffmandeco(huffman_enc, hf_dict);

assert(isequal(seq, arith_dec), 'Arithmetic coding output doesn''t match input');
assert(strcmp(char(shannon_dec)', input) == 1, 'Shannon-Fano coding output doesn''t match input');
assert(strcmp(char(huffman_dec)', input) == 1, 'Huffman coding output doesn''t match input');

fprintf('Length in bits of the message ''%s'' using the arithmetic coding: %d\n', input, length(arith_enc));
fprintf('Length in bits of the message ''%s'' using the Shannon-Fano coding: %d\n', input, length(shannon_enc));
fprintf('Length in bits of the message ''%s'' using the Huffman coding: %d\n', input, length(huffman_enc));

% Redundancy
r_arith = length(arith_enc) / length(input) - h;
len_shannon = cellfun('length', sh_dict);
r_shannon = sum(prob .* len_shannon(:, 2)') - h;
len_huffman = cellfun('length', hf_dict);
r_huffman = sum(prob .* len_huffman(:, 2)') - h;

fprintf('Redundancy of the message ''%s'' using the arithmetic coding: %f\n', input, r_arith);
fprintf('Redundancy of the message ''%s'' using the Shannon-Fano coding: %f\n', input, r_shannon);
fprintf('Redundancy of the message ''%s'' using the Huffman coding: %f\n', input, r_huffman);

end
