import json
from tempfile import mkdtemp
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options as ChromeOptions

def initialise_driver():
    chrome_options = ChromeOptions()
    chrome_options.add_argument("--headless=new")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")
    chrome_options.add_argument("--disable-gpu")
    chrome_options.add_argument("--disable-dev-tools")
    chrome_options.add_argument("--no-zygote")
    chrome_options.add_argument("--single-process")
    chrome_options.add_argument(f"--user-data-dir={mkdtemp()}")
    chrome_options.add_argument(f"--data-path={mkdtemp()}")
    chrome_options.add_argument(f"--disk-cache-dir={mkdtemp()}")
    chrome_options.add_argument("--remote-debugging-pipe")
    chrome_options.add_argument("--verbose")
    chrome_options.add_argument("--log-path=/tmp")
    chrome_options.binary_location = "/opt/chrome/chrome-linux64/chrome"

    driver = webdriver.Chrome(
        options=chrome_options
    )

    return driver

def ui_test(driver):
    '''
    Conduct UI test for UTS website
    '''
    try:
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

        # Click on Study Button -> Randomly finds a course to choose from to test
        find_course_xpath = f'/html/body/div[1]/div[3]/main/ul/li[1]/nav/div/ul/li[{rand_index}]/a'
        driver.get('https://www.uts.edu.au/study')
        driver.find_element(By.XPATH, find_course_xpath).click()

        # Click on Search Button then close Search Bar
        driver.find_element("id", 'site-search-toggle').click()
        driver.find_element("id", 'edit-search-keys').send_keys("UTS")
        driver.find_element(By.XPATH, '/html/body/div[1]/header/div[2]/div[2]/button').click()

        # Click on Staff Button
        # only the search button test and staff button test can work one at a time
        driver.get('https://staff.uts.edu.au/Pages/home.aspx')

    finally:
        result = "Test has ran sucessfully"
        driver.quit()
    return result

def lambda_handler(event, context):
    driver = initialise_driver()
    driver.get("https://www.uts.edu.au/")
    ui_test_status = ui_test(driver)

    body = {
        "title": driver.title,
        "status": ui_test_status
    }

    response = {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(body)
    }

    return response

