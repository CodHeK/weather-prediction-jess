(clear)

(deffunction prompt()
    (printout t "Wind Speed (mph): ")
    (bind ?answer (read))
    (call ?params put "wind" ?answer)

    (printout t "Relative humidity (%): ")
    (bind ?answer (read))
    (call ?params put "humidity" ?answer)

    (printout t "Temperature (deg cel): ")
    (bind ?answer (read))
    (call ?params put "temp" ?answer)

    (printout t "Atmospheric Pressure (hPa): ")
    (bind ?answer (read))
    (call ?params put "pressure" ?answer)
)

(reset)
(bind ?params (new java.util.Hashtable))

(deffunction check_param(?paramList ?threshold)
	(foreach ?param ?paramList
		(bind ?val (call ?params get ?param))
		(if (>= ?val ?threshold) then
			(return true)
     else
      (return false)
		)
	)
)

(defrule is_breeze
	=>
	(if (= (check_param (bind ?paramList (create$ "wind")) 20) false) then
		(printout t "Slight Breeze" crlf)
	)
)


(defrule is_windy
	=>
	(if (= (check_param (bind ?paramList (create$ "wind")) 60) true) then
		(printout t "Looks like it is too windy, could be a storm !" crlf)
	)
)

(defrule is_rainy
	=>
	(if (= (check_param (bind ?paramList (create$ "wind")) 20) true) then
    (if (= (check_param (bind ?paramList (create$ "temp")) 18) false) then
      (if (= (check_param (bind ?paramList (create$ "humidity")) 90) true) then
        (printout t "Might rain !" crlf)
      )
    )
	)
)

(defrule is_sunny
	=>
	(if (= (check_param (bind ?paramList (create$ "temp")) 25) true) then
    (if (= (check_param (bind ?paramList (create$ "humidity")) 50) false) then
      (printout t "Sunny" crlf)
    )
	)
)

(defrule is_cloudy
	=>
  (if (= (check_param (bind ?paramList (create$ "humidity")) 80) false) then
    (if (= (check_param (bind ?paramList (create$ "humidity")) 50) true) then
      (printout t "Cloudy" crlf)
    )
  )
)

(prompt)
(run)
