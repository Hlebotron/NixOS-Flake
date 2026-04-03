# set -x
rootDir=/opt/limit

maxMinsFile="$rootDir/maxMins"
dateFile="$rootDir/date"
ticksLeftFile="$rootDir/ticksLeft"
tickLengthFile="$rootDir/tickLengthSecs"
userFile="$rootDir/user"
ticksUsedFile="$rootDir/ticksUsed"

maxMins=15
user=maxim
tickLength=10
echo "$tickLength"
#mkdir $rootDir
#opening=
#closing=
echo $(cat $tickLengthFile)
if [[ -z $(cat $maxMinsFile) ]]; then
    echo $maxMins | tee $maxMinsFile
else
    maxMins=$(cat $maxMinsFile)
fi
if [[ -z $(cat $userFile) ]]; then
    echo $user | tee $userFile
else
    user=$(cat $userFile)
fi
if [[ -z $(cat $tickLengthFile) ]]; then
    echo "$tickLength | tee $tickLengthFile"
else
    tickLength=$(cat $tickLengthfile)
fi
echo "1"
echo "$tickLength"
echo "2"
if [[ -z $(cat $ticksLeftFile) ]]; then
    ticksLeft=$(($($maxMins) * 60 / $tickLength))
    echo $ticksLeft | tee $ticksLeftFile
fi
if [[ -z $(cat $ticksUsedFile) ]]; then
    echo 0 | tee $ticksUsedFile
fi
if [[ -z $(cat $dateFile) ]]; then
    echo $(date -I) | tee $dateFile
fi
echo "3"
echo "$tickLength"
currentDay1=$(cat $dateFile)
echo "4"
echo "$tickLength"
maxTicks=$((($maxMins * 60) / $tickLength))
echo "$tickLength"
echo "5"
while true; do
    echo "$tickLength"
    sleep $tickLength
    ticksLeft=$(cat $ticksLeftFile)
    currentDay1=$(cat $dateFile)
    currentDay2=$(date -I)

    if [ $currentDay1 != $currentDay2 ]; then
	echo $currentDay2 | tee $dateFile
	ticksLeft=$(($(cat $maxMinsFile) * 60 / $tickLength))
	echo $ticksLeft | tee $ticksLeftFile
	echo 0 | tee $ticksUsedFile
    fi

    if [[ $(users) == *"$user"* ]]; then
	id=$(pgrep -o -u $user)
	ticksLeft=$(($ticksLeft - 1))

	ticksUsed=$(cat $ticksUsedFile)
	ticksUsed=$(($ticksUsed + 1))
	echo $ticksUsed | tee $ticksUsedFile

	echo $ticksLeft | tee $ticksLeftFile

	if [ $ticksLeft -le 0 ]; then
	    kill -9 $id
	fi
    fi
done			
