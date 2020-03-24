def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  count = 0
  while count < collection.length do
    if name == collection[count][:item]
      return collection[count]
    else
      nil
    end
    count+= 1
  end
end

def consolidate_cart(cart)
  array = []
  count = 0
  while count < cart.length do
    new_cart_item = find_item_by_name_in_collection(cart[count][:item], array)
    if new_cart_item != nil
      new_cart_item[:count] += 1
    else
      new_cart_item = {
        :item => cart[count][:item],
        :price => cart[count][:price],
        :clearance => cart[count][:clearance],
        :count => 1
      }
      array << new_cart_item
    end
    count += 1
  end
  array
end

def apply_coupons(cart, coupons)
  count = 0
  while count < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[count][:item], cart)
    
    coupon_item_name = "#{coupons[count][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)
    
    if cart_item && cart_item[:count] >= coupons[count][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[count][:num]
        cart_item[:count] -= coupons[count][:num]
      else
        cart_item_with_coupon = {
          :item => coupon_item_name,
          :price => coupons[count][:cost] / coupons[count][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[count][:num]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[count][:num]
      end
    end
    count += 1
  end
  cart
end

def apply_clearance(cart)
  new_array = []
  counter = 0
  while counter < cart.length do
    new_array << cart[counter]
    counter += 1
  end
  counter2 = 0
  while counter2 < array.length do
    discounted_price = 0.0
    if array[counter2][:clearance] == true
      discounted_price = array[counter2][:price] - (array[counter2][:price] * 0.2)
      array[counter2][:price] = discounted_price.round(2)
    end
    counter2 += 1
  end
  new_array
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
