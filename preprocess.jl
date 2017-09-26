# Preprocessing script, written in julia6


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
    info
end

function Instance(x)
    @assert(length(x) == 8, "The datapoint seems broken $x")
    # The change in struct initialization happens here
    return Instance(x[1], x[2], x[3], x[4], x[5], x[6], x[7], x[8])
end


function readfile(tfile)
    [ Instance(split(line, "\t")) for line in eachline(tfile) ]
end


# Task description:
# Argument == claim + reason
# debateTitle == Topic
# debateInfo  == Additional Information
# w0, w1 

