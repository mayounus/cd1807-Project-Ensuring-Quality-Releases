# #!/usr/bin/env python
from selenium import webdriver
from selenium.webdriver.chrome.options import Options as ChromeOptions
from selenium.webdriver.common.by import By
import time
def login (user, password):
    options = ChromeOptions()
    options.add_argument("--headless") 
    options.add_argument("--disable-gpu")
    options.add_argument("--no-sandbox")
    driver = webdriver.Chrome(options=options)
    driver.get('https://saucedemo.com/')
    driver.find_element(By.ID,"user-name").send_keys(user)
    driver.find_element(By.ID,"password").send_keys(password)
    driver.find_element(By.ID,"login-button").click()
    time.sleep(3)
    print('UserID: ' + user)
    products = driver.find_elements(By.CSS_SELECTOR,"div[class='inventory_item']")
    i = 0
    for item in products:
        if i == 6:
            break
        try:
            print('Adding ' + item.find_element(By.CSS_SELECTOR,"div[class='inventory_item_name']").text + ' to cart.')
            item.find_element(By.CSS_SELECTOR,"button[class='btn btn_primary btn_small btn_inventory']").click()
            time.sleep(1)
            i += 1
        except:
            pass
    print('Conetnt count')
    time.sleep(2)
    counter_number=driver.find_element(By.XPATH,".//span[@class='shopping_cart_badge']").text
    print(counter_number + ' Cart items')
    print('Delete cart items')
    for prod in products:
        print('Deleting ' + item.find_element(By.CSS_SELECTOR,"div[class='inventory_item_name']").text)
        prod.find_element(By.CSS_SELECTOR,"button[class='btn btn_secondary btn_small btn_inventory']").click()
        time.sleep(1)
    driver.close()  
login('problem_user', 'secret_sauce')
