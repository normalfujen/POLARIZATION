pro sixs_2v_rayleigh_depolarization
  
  current_dir = '/home/normale/6s/SharedData'
  file=current_dir+'/IGBP_Data_for_16_Classes/IGBP1-Dave.csv'
  
  file2 = current_dir+'/IGBP_Surface_reflectance/IGBP_01_final.csv'
  data2=READ_CSV(file2)
  rou_array=data2.(3)
  
  data=READ_CSV(file)
    

  solar_zenith_array=data.(0)
  view_zenith_array=data.(1)
  sun_azimuth=180
  relative_azimuth_array=data.(2)
  p_reflectance_measured_array=data.(3)
  view_azimuth_array=(relative_azimuth_array+180) mod 360
  
  data_length = N_ELEMENTS(solar_zenith_array)
  
  openw,lun2,'toa_p_IGBP01_measured',/get_lun
  FOR i = 0L, data_length-1 DO BEGIN
    IGEOM = 0
    sun_zenith=solar_zenith_array[i]
    view_zenith=view_zenith_array[i]
    view_azimuth=view_azimuth_array[i]
    month=7
    day=23
    IDATM=2
    IAER=1
    V=0
    AOD = 0.0001;randomu(undefinevar) * 0.1
    XPS=0
    XPP=-1000
    IWAVE=-1
    lamda=0.86
    INHOMO=0
    IDIREC=0
    IGROUN=0
    rou = rou_array[i]
    IRAPP=-1
    BPDF=4
    pol_reflectance = p_reflectance_measured_array[i]

    OPENW,LUN,'input',/GET_LUN
    PRINTF,LUN,IGEOM
    PRINTF,LUN,sun_zenith
    PRINTF,LUN,sun_azimuth
    PRINTF,LUN,view_zenith
    PRINTF,LUN,view_azimuth
    PRINTF,LUN,month
    PRINTF,LUN,day
    PRINTF,LUN,IDATM
    PRINTF,LUN,IAER
    PRINTF,LUN,V
    PRINTF,LUN,AOD
    PRINTF,LUN,XPS
    PRINTF,LUN,XPP
    PRINTF,LUN,IWAVE
    PRINTF,LUN,lamda
    PRINTF,LUN,INHOMO
    PRINTF,LUN,IDIREC
    PRINTF,LUN,IGROUN
    PRINTF,LUN,rou
    PRINTF,LUN,IRAPP
    ;PRINTF,LUN,BPDF
    ;pol_reflectance_transfer,sun_zenith,sun_azimuth,view_zenith,view_azimuth,pol_reflectance,$
    ;  ropq,ropu
    ;PRINTF,LUN,ropq
    ;PRINTF,LUN,ropu
    FREE_LUN,LUN
    spawn, './sixsV2.1'    
  ENDFOR  
  free_lun,lun2
  FILE_MOVE,'output_data','output_data_Depolarization'
end
