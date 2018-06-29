# https://blog.kissmetrics.com/facebook-statistics/
#!/bin/bash
import numpy as np
import sys
def gen_data(avg):
	re = np.random.normal(avg, 0.2, 100)
	print re
def gen_data_limit(avg, limit):
	re = []
	while(True):
		re.append(int(np.random.gamma(avg)))
		print re[len(re)-1], np.sum(re) 
		if np.sum(re) > limit:
			print "get out"
			return re
	return re
# first is the number of the first parameter
def gen_data_first(avg, first):
	#print "avg is :", avg
	re = []
	count = 0
	while(True):
		count = count + 1
		re.append(int(np.random.gamma(avg)))
		if count > first:
			return re
	return re
def write(re, filename):
	dat = open(filename,'w')
	for d in re:
		dat.write(str(d))
		dat.write("\n")
	dat.close
def main():
	size = 200
	if len(sys.argv) > 1:	
		size = int(sys.argv[1])
	print "size: ", size
	users = 338116
	posts = 1900984
	comments = 1411828
	friends = 130
	tags = 5
	groups = 1000
	families = 200
	r1 = gen_data_limit(posts/users, size)
	filename = "user_news.txt"
	write(r1, filename)
	
	r1 = gen_data_first(comments/users, len(r1))
	filename = "user_comments.txt"
	write(r1, filename)
	
	r1 = gen_data_first(friends, len(r1))
	filename = "user_users.txt"
	write(r1, filename)	
	
	
	r1 = gen_data_first(families, len(r1))
	filename = "family_users.txt"
	write(r1, filename)	
	
	
	r1 = gen_data_first(groups, len(r1))
	filename = "group_users.txt"
	write(r1, filename)	
	
if __name__ == '__main__':
	main()