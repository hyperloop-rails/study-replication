import numpy as np
def computeDistribution(filename):
	f = open(filename)
	bin = []
	num = []
	for line in f:
		data = line.strip().split('\t')
		bin.append(int(data[0]))
		num.append(int(data[1]))
	length = bin[len(bin) - 1]
	print "length:", length
	prob = np.zeros(length)
	sum_num = np.sum(num)
	i = 0
	# compute the probability distribution thru the distribution
	for index in range(len(bin)):
		if index == 0:
			for j in range(bin[index]):
				prob[j] = num[index] * 1.0/(sum_num*bin[index])
		else:
			for j in range(bin[index-1],bin[index]):
				prob[j] = num[index] * 1.0/(sum_num*(bin[index]-bin[index-1]))
	print np.sum(prob)
	return xrange(length), prob
def gen_num(prob, size):
	re = []
	for i in range(size):
		re.append(np.random.choice(np.arange(0,len(prob)), p = prob))
	return re
	
def gen_data(filename, size):
	bin, prob = computeDistribution(filename)
	re = gen_num(prob, 400)
	dat = open(str(filename) +".dat",'w')
	for d in re:
		dat.write(str(d))
		dat.write("\n")
	return re
def gen_data_limit(filename, limit):
	bin, prob = computeDistribution(filename)
	re = []
	while(True):
		re += gen_num(prob, 50) 
		if np.sum(re) >=  limit:
			break
	dat = open(str(filename) +".dat",'w')
	for d in re:
		dat.write(str(d))
		dat.write("\n")
	return np.sum(re)	
def main():
	limit = 200
	if len(sys.argv > 1):
		limit = int(sys.argv[1])
	filename = 'user_projects.txt'
	re = gen_data_limit(filename, limit)
	
	filename = 'project_commits.txt'
	gen_data(filename, np.sum(re))

	filename = 'project_branches.txt'
	gen_data(filename, np.sum(re))
	
	filename = 'project_issues.txt'
	gen_data(filename, np.sum(re))

	filename = 'user_members.txt'
	gen_data(filename, np.sum(re))
	
if __name__ == '__main__':
	main()