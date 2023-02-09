#Imports
import time
import pandas as pd
import numpy as np
from utils import *
from all_fgains import *
import argparse
import tensorflow.compat.v1 as tf

def main(data, mask, batch_size, hint_rate, alpha, iterations, loss_fn):
  '''Main function for UCI letter and spam datasets.
  
  Args:
    - data: pandas dataframe of the data
    - mask: a pandas dataframe with 1,0's
    - batch:size: batch size
    - hint_rate: hint rate
    - alpha: hyperparameter
    - iterations: iterations
    
  Returns:
    - imputed_data_x: imputed data
    - rmse: Root Mean Squared Error
  '''

  gain_parameters = {'batch_size': batch_size,
                     'hint_rate': hint_rate,
                     'alpha': alpha,
                     'iterations': iterations} 
  
  # Load data and introduce missingness
  ori_data_x, miss_data_x, data_m = mask_data_loader(data, mask)
  
  #Uses the loss function given
  if loss_fn == "Forward_KL":
    imputed_data_x = gain_ForwardKL(miss_data_x, gain_parameters)
  elif loss_fn == "Reverse_KL":
    imputed_data_x = gain_ReverseKL(miss_data_x, gain_parameters)
  elif loss_fn == "Jensen_Shannon":
    imputed_data_x = gain_jen_shan(miss_data_x, gain_parameters)
  elif loss_fn == "Pearsom_Chi_Squared":
    imputed_data_x = gain_Pearsomh_chi(miss_data_x, gain_parameters)
  elif loss_fn == "Square_Hellingr":
    imputed_data_x = gain_squared_hell(miss_data_x, gain_parameters)
  elif loss_fn == "original":
    imputed_data_x = gain(miss_data_x, gain_parameters)
  else:
    return "The loss function given wasn't on the list"
  
  # Report the RMSE performance
  rmse = rmse_loss(ori_data_x, imputed_data_x, data_m)
  
  print()
  print('RMSE Performance: ' + str(np.round(rmse, 4)))
  
  return imputed_data_x, rmse

if __name__ == "__main__":
    #Set of starting variables
    dataFPath = ""
    loss_func = ""
    #miss_rate = .2
    batch_size = 128
    hint_rate = .9
    alpha = 100
    iterations = 10000
    #get inputs
    parser = argparse.ArgumentParser()
    parser.add_argument("-d", "--dataFile", help="Uses the given data at the file path")
    parser.add_argument("-m", "--maskFile", help="the masked file path")
    parser.add_argument("-l", "--lossFn",help="Uses what loss function is given")
    
    
    #read arguments
    args = parser.parse_args()
    dataFPath = args.dataFile
    loss_func = args.lossFn
    maskFPath = args.maskFile
    
    #Trys to read the mask file
    try:
        m_df = pd.read_csv(maskFPath, delimiter=',', index_col=0)
    except FileNotFoundError:
        print("Can't find File {0}".format(maskFPath))
        exit(1)
    #trys to read the data file
    try:
        x_df = pd.read_csv(dataFPath, delimiter=',', index_col=0)
    except FileNotFoundError:
        print("Can't find File {0}".format(dataFPath))
        exit(1)
    #runs the main function of the gain
    imputated_data , rmse = main(x_df, m_df, batch_size, hint_rate, alpha, iterations, loss_func)
    #saves the imputated data out to a file with the name of the loss function 
    outputFileName = "/data/projects/zackary.hopkins/imputated_Data/{0}_{1}_imputated_data.csv".format(maskFPath[-14:-4], loss_func)
    np.savetxt(outputFileName, imputated_data, delimiter=",")
    #outputs the results
    print("The imputated data has been saved to {0} RMSE: {1}".format(outputFileName, rmse))
    
    

