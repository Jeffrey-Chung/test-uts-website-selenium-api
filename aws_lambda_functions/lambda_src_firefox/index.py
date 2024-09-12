import json
import random
from selenium import webdriver
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.firefox.options import Options as FirefoxOptions
from selenium.webdriver.common.by import By

undergrad_and_postgrad_course_areas = [
'Analytics and Data Science',
'Business',
'Communication',
'Design, Architecture and Building',
'Education',
'Engineering',
'Health',
'Health(GEM)',
'Information Technology',
'International Studies and Social Sciences',
'Law',
'Science and Mathematics',
'Transdisciplinary Innovation'
]

def initialise_driver():
    firefox_options = FirefoxOptions()
    firefox_options.binary_location = "/opt/firefox/firefox"
    firefox_options.add_argument("--headless")
    firefox_options.add_argument("--no-sandbox")
    firefox_options.add_argument("--disable-dev-shm-usage")
    firefox_options.add_argument("--disable-gpu")
    firefox_options.add_argument("--disable-dev-tools")
    firefox_options.add_argument("--no-zygote")
    firefox_options.add_argument("--single-process")
    firefox_options.add_argument("window-size=2560x1440")
    firefox_options.add_argument("--user-data-dir=/tmp/firefox-user-data")
    firefox_options.add_argument("--remote-debugging-port=9222")
    firefox_service = Service(executable_path = "/opt/geckodriver")
    driver = webdriver.Firefox(service=firefox_service, options=firefox_options)
    return driver

def ui_test(driver):
    '''
    Conduct UI test for UTS website
    '''
    # Check if the website has a valid certificate by starting with http://
    if driver.current_url.startswith('https://'):
        print("The website has a valid certificate.")
    else:
        print("The website does not have a valid certificate.")

    # Click on Arrow keys on What's Happening Section
    left_arrow_key_xpath = '/html/body/div[1]/div[2]/div[1]/div/button[1]'
    right_arrow_key_xpath = '/html/body/div[1]/div[2]/div[1]/div/button[3]'
    driver.find_element(By.XPATH, left_arrow_key_xpath).click()
    driver.find_element(By.XPATH, right_arrow_key_xpath).click()

    rand_index = random.randint(1, 13)
    undergrad_and_postgrad_course = undergrad_and_postgrad_course_areas[rand_index-1]
    print("You have tested this course area: " + undergrad_and_postgrad_course)

    # Click on Explore Course Areas -> Finds a random course area to choose from
    shortened_xpath = '/html/body/div[1]/div[2]/div[2]/div[1]/div/div[2]/div[1]/div[2]/section/'
    explore_course_areas_xpath = shortened_xpath + 'h4'
    ug_and_pg_course_areas_xpath = shortened_xpath + f'div/ul/li[{rand_index}]/a'
    driver.find_element(By.XPATH, explore_course_areas_xpath).click()
    driver.find_element(By.XPATH, ug_and_pg_course_areas_xpath).click()

    # Click on Search Button then close Search Bar
    driver.find_element("id", 'site-search-toggle').click()
    driver.find_element("id", 'edit-search-keys').send_keys("UTS")
    driver.find_element(By.XPATH, '/html/body/div[1]/header/div[2]/div[2]/button').click()

    # Click on Staff Button
    # only the search button test and staff button test can work one at a time
    driver.get('https://staff.uts.edu.au/Pages/home.aspx')
    driver.quit()

def lambda_handler(event=None, context=None):
    driver = initialise_driver()
    driver.get("https://www.uts.edu.au/")
    ui_test(driver)
    response = {
        "statusCode": 200,
        "body": json.dumps(
            {
                "status": "Test has ran sucessfully"
            }
        )
    }
    return response

