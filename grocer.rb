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
  while counter2 < new_array.length do
    discounted_price = 0.0
    if new_array[counter2][:clearance] == true
      discounted_price = new_array[counter2][:price] - (new_array[counter2][:price] * 0.2)
      new_array[counter2][:price] = discounted_price.round(2)
    end
    counter2 += 1
  end
  new_array
end

def checkout(cart, coupons)
  consolidate_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidate_cart)
  clearanced_car = apply_clearance(couponed_cart)
end
