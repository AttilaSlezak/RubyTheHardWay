class RandomNumber
  def self.generate_weighted_rand_num(value)
    random_nums = []
	70.times {a = rand(150); random_nums.push(a)}
	70.times {a = rand(450); random_nums.push(a)}
	25.times {a = rand(1000); random_nums.push(a)}
	9.times {a = rand(2000); random_nums.push(a)}
	2.times {a = rand(7000); random_nums.push(a)}
	ballance = 1.1
	if value < 3.0
	  ballance = 1.15
	elsif value < 1.2
	  ballance = 1.2
	elsif value > 3000
	  ballance = 1.0
	end
	if rand(2) == 1
	  return random_nums[rand(176)] * ballance / 10000.0 + 1
	else
	  return 1 - (random_nums[rand(176)] / 10000.0)
	end
  end
end