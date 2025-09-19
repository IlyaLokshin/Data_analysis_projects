# Retail Business: Profitability Analysis with SQL and Power BI

## 1. Data Source
A [free dataset](https://www.kaggle.com/datasets/kunalmalviya06/retail-sales-returns-and-shipping-dataset) from Kaggle (“Retail Sales, Returns & Shipping Dataset”). 

## 2. Skills
- SQL (creating schemas, data normalization, aggregating, sorting, grouping, filtering data, joining sets, subqueries, CTEs);
- Visualizations in Power BI, DAX functions

## 3. The Business Problem
The task is to conduct a profitability analysis that identifies drivers of revenue, profit and losses in order to optimize business performance and develop specific recommendations for increasing profits and decreasing losses.

## 4. Results and Recommendations

### 4.1. Drivers of losses

#### 4.1.1. Lossmaking product categories
Four product subcategories – fasteners, bookcases, supplies and tables – have a negative profit margin. 

*Figure 1*

![Figure 1](https://i.ibb.co/mC7hswKJ/Figure-1.png)

It is recommended either to reduce the COGS, or to increase price, or to decrease the proportion of these product categories in the business’s operations, with shifting focus toward more profitable product categories. The need for these measures is exacerbated by the fact that tables are among the products with the highest sales volume.

*Figure 2*

![Figure 2](https://i.ibb.co/ymyzgy8g/Figure-2.png)

An important question is a) whether there is an accumulated stock of tables with sunk costs which have to be compensated by sales anyway or b) tables are produced or bought wholesale to satisfy high demand. If (b) is true, the lossmaking effect of tables is especially pronounced.

A conspicuous phenomenon is the widening gap between total sales (red line) and profits (blue line) since 2017. The “normal” pattern when sales and profits rise in parallel was observed practically in all periods before 2017. What has caused this change? 

*Figure 3*

![Figure 3](https://i.ibb.co/Q3V5Vg9Y/Figure-3.png)

A strong hypothesis is that an increase in sales of tables – a lossmaking product category – drives this discrepancy between sales and profit.

*Figure 4. Data for the Tables subcategory*

![Figure 4](https://i.ibb.co/rX80Gkb/Figure-4.png)

Currently average losses per year brought about by Tables subcategory are equal to approximately $23,500, which is close to 8.5% of the average annual net profit (≈ $277,800). Decreasing COGS for Tables category by 10% would result in eliminating these losses, with a corresponding increase in the net profit. 

Thus, solving the problems associated with four lossmaking product categories, especially Tables, should be an effective way to increase business profitability.

#### 4.1.2. Shipping costs
As we can see from the visualization below, California and Texas are far ahead of other states in terms of total shipping costs. This is due to the combination of large sales volume and a high shipping cost per unit (especially for California).

*Figure 5*

![Figure 5](https://i.ibb.co/Rp6FrKwc/Figure-5.png)

Is decreasing shipping costs for these two states a promising way of increasing business profitability? Decreasing shipping costs from $7 dollars per unit to $5 for California and from $10 to $8 in Texas would result in approximately $6,500 decrease in costs per year, which is less than 2.5% of current average annual net profit Thus, reducing shipping costs per unit (at least for these two states) hardly should be a top priority. 

#### 4.1.3. Distribution of sales across the year
A graph for average order values (AOV) per quarter suggests that there might be some seasonal effects in the data.

*Figure 6*

![Figure 6](https://i.ibb.co/V0ZZpwGw/Figure-6.png)

However, a graph for months makes clear this is not a seasonal effect in the precise sense of the term: instead, the observed pattern is primarily influenced by lower AOVs in February.

*Figure 7*

![Figure 7](https://i.ibb.co/psbfVxF/Figure-7.png)

The following graph shows AOV for February across different years. AOV for February indeed tends to be lower than for other months, but we also may notice that there are significant variations across different years; in particular, AOV in February 2016 was not lower than for other months. This pattern suggests that low order values in February are driven by some changeable factors. Average number of orders in February is 41.25, with AOV equal to approximately $1,400. The increase of AOV for February to the current overall average (approximately $2,100) would result in almost $30,000 increase in sales, which could translate to approximately $3,000 increase in net profits (taking into account profit margin). As in the previous case with shipping costs, this gain in net profits is not impressive (around 2.5% of the annual net profits) and should not be a top priority. 

*Figure 8. AOV for February across different years*

![Figure 8](https://i.ibb.co/pv71qJ1x/Figure-8.png)

#### 4.1.4. Discount policies
It can be seen on the scatterplots of discount values and quantities of the products sold that there is a noticeable positive correlation between the variables (see below the scatterplots without filters, but scatterplots for subsets of data look similar).

*Figure 9*

![Figure 9](https://i.ibb.co/bj0h92QG/Figure-9.png)

The lack of positive correlation between these variables suggests that discounts do not contribute to the increase of sales. If so, it may be beneficial to revise the discount policies.

For example, a 10% reduction in discount values would result in more than $35,000 average increase in annual net profits (or more than 13% of average annual net profits).  

### 4.2. Underexploited Drivers of Profits

#### 4.2.1. Profit-generating categories of products with low sales
As we could see on the first graph above, copiers, paper, envelopes and labels are the product subcategories generating the most net profit per sale. However, only copiers are in the top 10 products per sale, and none are in the top 5. An increase in sales of products from these subcategories is a potentially efficient way of increasing business profitability.

In particular, a 10% increase in sales of products from each of these subcategories would result in additional ≈$9,500 (≈3.5%) of net profits per year. However, this is not a particularly impressive improvement.

#### 4.2.2. Geographical dimension: underexploited potential 
From the graph below we may notice that two regions – East and West – tend to lead in terms of sales volume. However, there is a peculiar observation concerning the Central region: while sales volume is modest for most of the period, it surged impressively in the 4th quarter of 2016. 

*Figure 10*

![Figure 10](https://i.ibb.co/0y4hHztX/Figure-10.png)

If we zoom in to this particular period, we may see that two states from the Central region – Michigan and Indiana – became clear leaders in terms of the net profit, leaving behind the overall leader, California. 

*Figure 11*

![Figure 11. Data for the 4th quarter of 2016](https://i.ibb.co/yc4stsp9/Figure-11.png)

What if it would be possible to recreate the conditions of the 4th quarter of 2016 in other periods? It may be worthwhile to investigate what factors contributed to the increase in sales and profits during that period. If these factors would turn out to be flexible, then it would be possible to utilize them in order to increase business profitability in these two states in particular and in the Central region in general. 

If it would be possible for the Central region to consistently achieve (for every quarter in a year) merely 10% of the net profit of the exceedingly successful 4th quarter of 2016, the total average annual net profit would increase by more than $20,000 (≈7.5%).  

#### 4.3. Final recommendations 

