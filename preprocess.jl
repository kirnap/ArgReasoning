# Preprocessing script, written in julia6

# Some useful constants
const unkchar = '\x11'
# Train data:
const traindir = "/ai/data/nlp/semeval2018/t12/train-full.txt"

# Dev data:
const devdir = "/ai/data/nlp/semeval2018/t12/dev-full.txt"


type Instance
    id
    w0
    w1
    correctLabel
    reason
    claim
    title
    inform
end


function Instance(x, chvoc)
    @assert(length(x) == 8, "The datapoint seems broken $x")
    # The change in struct initialization happens here
    f(t) = word2Indx(t, chvoc)
    id = x[1]
    w0 = map(f, split(x[2]))
    w1 = map(f, split(x[3]))
    correctLabel = x[4]
    reason = map(f, split(x[5]))
    claim = map(f, split(x[6]))
    title = map(f, split(x[7]))
    inform = map(f, split(x[8]))
    return Instance(id, w0, w1, correctLabel, reason, claim, title, inform)
end


function readfile(tfile, chvoc)
    [ Instance(split(line, "\t"), chvoc) for line in eachline(tfile) ]
end


word2Indx(word, chvoc) = [ get(chvoc, item, chvoc[unkchar]) for item in word ]



# Task description:
# Argument == claim + reason
# debateTitle == Topic
# debateInfo  == Additional Information
# w0, w1

# The initially created language model can be found in:
# ../deeparse/data/english_chmodel.jld
