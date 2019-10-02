using Test

include("protein_translation.jl")

# Tests adapted from `problem-specifications//canonical-data.json` @ v1.1.1

@testset "AUG translates to methionine" begin
    @test proteins("AUG") == ["Methionine"]
end

@testset "identifies Phenylalanine codons" begin
    for codon in ["UUU", "UUC"]
        @test proteins(codon) == ["Phenylalanine"]
    end
end

@testset "identifies Leucine codons" begin
    for codon in ["UUA", "UUG"]
        @test proteins(codon) == ["Leucine"]
    end
end

@testset "identifies Serine codons" begin
    for codon in ["UCU", "UCC", "UCA", "UCG"]
        @test proteins(codon) == ["Serine"]
    end
end

@testset "identifies Tyrosine codons" begin
    for codon in ["UAU", "UAC"]
        @test proteins(codon) == ["Tyrosine"]
    end
end

@testset "identifies Cysteine codons" begin
    for codon in ["UGU", "UGC"]
        @test proteins(codon) == ["Cysteine"]
    end
end

@testset "identifies Tryptophan codons" begin
    @test proteins("UGG") == ["Tryptophan"]
end

@testset "identifies stop codons" begin
    for codon in ["UAA", "UAG", "UGA"]
        @test proteins(codon) == []
    end
end

@testset "translates rna strand into correct protein list" begin
    strand = "AUGUUUUGG"
    expected = ["Methionine", "Phenylalanine", "Tryptophan"]
    @test proteins(strand) == expected
end

@testset "stops translation if stop codon at beginning of sequence" begin
    strand = "UAGUGG"
    expected = []
    @test proteins(strand) == expected
end

@testset "stops translation if stop codon at end of two codon sequence" begin
    strand = "UGGUAG"
    expected = ["Tryptophan"]
    @test proteins(strand) == expected
end

@testset "stops translation if stop codon at end of three codon sequence" begin
    strand = "AUGUUUUAA"
    expected = ["Methionine", "Phenylalanine"]
    @test proteins(strand) == expected
end

@testset "stops translation if stop codon in middle of three codon sequence" begin
    strand = "UGGUAGUGG"
    expected = ["Tryptophan"]
    @test proteins(strand) == expected
end

@testset "stops translation if stop codon in middle of six codon sequence" begin
    strand = "UGGUGUUAUUAAUGGUUU"
    expected = ["Tryptophan", "Cysteine", "Tyrosine"]
    @test proteins(strand) == expected
end
