def stock_picker(stock_prices)
  result = Array.new(0)
  profit = 0
  stock_prices.each_with_index do |before_price, before_day|
    stock_prices.each_with_index do |after_price, after_day|
      if before_day < after_day
        total =  stock_prices[after_day] - stock_prices[before_day]
        if total > profit
          profit = total
          result = [before_day, after_day]
        end
      end
    end
  end
  result
end

print stock_picker([17,3,6,9,15,8,6,1,10])