CORPUS=text8
VOCAB_FILE=vocab.txt
COOCCURRENCE_FILE=cooccurrence.bin
COOCCURRENCE_SHUF_FILE=cooccurrence.shuf.bin
SAVE_FILE=vectors
VERBOSE=2
MEMORY=4.0
VOCAB_MIN_COUNT=1
VECTOR_SIZE=300
MAX_ITER=500
WINDOW_SIZE=15
BINARY=2
NUM_THREADS=64
X_MAX=10


echo "start vocab count...."
echo "================"

./vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $CORPUS > $VOCAB_FILE

echo "finish vocab count..."
echo "==============="

echo "start cooccur compute..."
echo "============"
./cooccur -memory $MEMORY -vocab-file $VOCAB_FILE -verbose $VERBOSE -window-size $WINDOW_SIZE < $CORPUS > $COOCCURRENCE_FILE
echo "finish cooccur compute..."
echo "============"

echo "start shuffle..."
echo "================"
./shuffle -memory $MEMORY -verbose $VERBOSE < $COOCCURRENCE_FILE > $COOCCURRENCE_SHUF_FILE
echo "finish shuffle..."
echo "==============="

echo "start glove..."
echo "=============="
./glove -save-file $SAVE_FILE -threads $NUM_THREADS -input-file $COOCCURRENCE_FILE -x-max $X_MAX -iter $MAX_ITER -vector-size $VECTOR_SIZE -binary $BINARY -vocab-file $VOCAB_FILE -verbose $VERBOSE
echo "finish glove..."
echo "=============="
