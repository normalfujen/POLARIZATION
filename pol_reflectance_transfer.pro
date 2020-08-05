pro pol_reflectance_transfer,sun_zenith,sun_azimuth,view_zenith,view_azimuth,pol_reflectance,$
                             ropq,ropu
                             
  
  dtr = !pi/180.0D  
  relative_azimuth = abs(sun_azimuth - view_azimuth)
  csca = -cos(sun_zenith*dtr)*cos(view_zenith*dtr) - sin(sun_zenith*dtr)*sin(view_zenith*dtr)*cos(relative_azimuth*dtr)
 ; begin to tranfer rotation angle for Q and U
  muv = cos(view_zenith*dtr)
  mus = cos(sun_zenith*dtr)
  sinv = sin(view_zenith*dtr)
  
  if (view_zenith gt 0.5) then begin
    if (sin(relative_azimuth*dtr) lt 0.0) then begin
      cksi = (muv*csca + mus)/sqrt(1.0 - csca*csca)/sinv
    endif else begin
      cksi = -(muv*csca + mus)/sqrt(1.0 - csca*csca)/sinv
    endelse    
  endif else begin
    cksi = 0.0
  endelse
  
  if (cksi gt 1.0) then begin
    cksi = 1.0
  endif
  
  if (cksi lt -1.0) then begin
    cksi = -1.0
  endif
  ksi = acos(cksi)/dtr
  ropq = pol_reflectance * (2.0 * cksi * cksi -1.0)
  ropu = -pol_reflectance *2.0*cksi*sqrt(1.0 - cksi*cksi)
end