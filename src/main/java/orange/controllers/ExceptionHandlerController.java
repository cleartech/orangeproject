package orange.controllers;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@ControllerAdvice
public class ExceptionHandlerController {

    public static final String DEFAULT_ERROR_VIEW = "Error page";

    @ExceptionHandler(value = {Exception.class, RuntimeException.class})
    public ModelAndView defaultHandler(HttpServletRequest request, Exception e) {
        ModelAndView modelAndView = new ModelAndView(DEFAULT_ERROR_VIEW);
        modelAndView.addObject("datetime", new Date());
        modelAndView.addObject("exception", e);
        modelAndView.addObject("exceptionMessage", e.getMessage());
        modelAndView.addObject("url", request);
        modelAndView.addObject("uri", request.getRequestURI());

        return modelAndView;
    }
}
