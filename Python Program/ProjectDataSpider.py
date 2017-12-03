# -*- coding: utf-8 -*-
import scrapy
import os 
import json
#import MySQLdb

class ProjectdataspiderSpider(scrapy.Spider):
    name = 'ProjectDataSpider'
    allowed_domains = ['reuters.com/resources/archive/us/']
    #start_urls = ['http://www.reuters.com/resources/archive/us/20161231.html']
    start_urls = ['http://www.reuters.com/resources/archive/us/2007.html']
    #urls = 'http://www.reuters.com/resources/archive/us/2016.html'
    #urls = start_urls[0]+str(2016)+'.html'
    def start_request(self):
    	base_url = 'http://www.reuters.com/resources/archive/us/2007.html'
    	yield scrapy.Request(url = base_url,callback=self.parse)

    def parse(self,response):
        days = response.xpath("//p/a[starts-with(@href, \
                              '/resources/archive/us/')]")
        for day in days:
        	day_url = day.xpath('@href').extract_first()
        	#Extrqct_first和extract的区别就是extract_first返回的是string，而extract返回的是一个包含这个string的list
        	date = day_url.split("/")[-1][:-5]
        	item = {'date':date}
        	full_url = response.urljoin(day_url)
        	yield scrapy.Request(url=full_url, callback = self.parse_page,dont_filter=True,meta={'item':item})
    
    def parse_page(self,response):
    	articles = response.xpath("//div[contains(@class,'headlineMed')]/a/text()").extract()
    	time = response.xpath("//div[contains(@class,'headlineMed')]/text()").extract()
    	item = response.meta['item']
    	date = item['date']

    	new_time = [date + s for s in time]
    	#date_times = str(date)+str(time)
    	dictionary = dict(zip(articles, new_time))
    	yield dictionary



"""
conn = MySQLdb.connect('localhost','root','Pine684253#','twi_sentiment',charset='utf8mb4')
cur = conn.cursor()
import MySQLdb
cur.execute("INSERT INTO tweetTable (time,username,tweet) VALUES (%s,%s,%s)",(time.time(),username,tweet_clean))
conn.commit()
print username,tweet_clean
return True
"""