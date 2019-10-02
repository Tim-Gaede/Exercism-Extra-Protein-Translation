function proteins(strand::String)
    protein_from = Dict("AUG" => "Methionine",
                        "UUU" => "Phenylalanine",
                        "UUC" => "Phenylalanine",
                        "UUA" => "Leucine",
                        "UUG" => "Leucine",
                        "UCU" => "Serine",
                        "UCC" => "Serine",
                        "UCA" => "Serine",
                        "UCG" => "Serine",
                        "UAU" => "Tyrosine",
                        "UAC" => "Tyrosine",
                        "UGU" => "Cysteine",
                        "UGC" => "Cysteine",
                        "UGG" => "Tryptophan",
                        "UAA" => "STOP",
                        "UAG" => "STOP",
                        "UGA" => "STOP")


    numCodons = length(strand) ÷ 3
    result = String[]
    stop_found = false
    n = 1
    while n ≤ numCodons  &&  !stop_found
        codon = strand[3*n - 2 : 3*n]
        if protein_from[codon] == "STOP"
            stop_found = true
        else
            push!(result, protein_from[codon])
            n += 1
        end
    end


    result # returned
end
