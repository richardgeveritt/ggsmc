#' A histogram of a single variable from a single target.
#'
#' @param output Output from the SMC or EnK algorithm.
#' @param x_parameter The parameter indexed by the x-axis.
#' @param y_parameter The parameter indexed by the y-axis.
#' @param target (optional) The index of the target we wish to plot (default to final target).
#' @param pre_weighting (optional) If TRUE, will ignore particle weights in the histogram. If FALSE, will use the particle weights (defaults to FALSE).
#' @param xlimits (optional) Input of the form c(start,end), which specifies the ends of the x-axis.
#' @param ylimits (optional) Input of the form c(start,end), which specifies the ends of the y-axis.
#' @param default_title (optional) If TRUE, will provide a default title for the figure. If FALSE, no title is used (defaults to FALSE).
#' @param max_size (optional) The maximum size of the points in the plot (default=1).
#' @param alpha (optional) The transparency of the points in the plot (default=0.1).
#' @return A scatter plot in a ggplot figure.
#' @export
scatter_plot = function(output,
                        x_parameter,
                        y_parameter,
                        target=NULL,
                        pre_weighting=FALSE,
                        xlimits=NULL,
                        ylimits=NULL,
                        default_title=FALSE,
                        max_size=1,
                        alpha=0.1)
{
  if ("Value" %in% names(output))
  {
    output_to_use = tidyr::pivot_wider(output,names_from=Parameter,values_from=Value)
  }
  else
  {
    output_to_use = output
  }

  if (!is.null(target))
  {
    target_parameters = dplyr::filter(output_to_use,Target==target)$TargetParameters[1]
    output_to_use = dplyr::filter(output_to_use,Target==target)
  }

  if ( ("LogWeight" %in% names(output)) && (pre_weighting==FALSE) )
  {
    plot = ggplot2::ggplot(output_to_use, ggplot2::aes(x=.data[[x_parameter]],
                                                       y=.data[[y_parameter]],
                                                       size=exp(LogWeight)))
  }
  else
  {
    plot = ggplot2::ggplot(output_to_use, ggplot2::aes(x=x_parameter,
                                                       y=y_parameter))
  }


  x_split_result = stringr::str_split(x_parameter, "(?<=\\D)(?=\\d)|(?<=\\d)(?=\\D)", n = Inf, simplify = TRUE)
  y_split_result = stringr::str_split(y_parameter, "(?<=\\D)(?=\\d)|(?<=\\d)(?=\\D)", n = Inf, simplify = TRUE)

  if ( (ncol(x_split_result)>2) || (ncol(x_split_result)==0) || (ncol(y_split_result)>2) || (ncol(y_split_result)==0) )
  {
    stop("For automated captions, parameters need to be of the form charactersnumber.")
  }
  else if ( (ncol(x_split_result)==1) && (ncol(y_split_result)==1) )
  {
    x_parameter_for_plot = x_parameter
    y_parameter_for_plot = y_parameter
    if (is.null(target))
    {
      default_title_for_plot = bquote("Scatter plot of"~.(x_parameter)~"and"~.(y_parameter))
    }
    else
    {
      default_title_for_plot = bquote("Scatter plot of"~.(x_parameter)~"and"~.(y_parameter)~"("*.(target_parameters)*")")
    }
  }
  else if ( (ncol(x_split_result)==2) && (ncol(y_split_result)==1) )
  {
    if (is.null(target))
    {
      default_title_for_plot = bquote("Scatter plot of"~.(x_split_result[1])[.(x_split_result[2])]~"and"~.(y_parameter))
    }
    else
    {
      default_title_for_plot = bquote("Scatter plot of"~.(x_split_result[1])[.(x_split_result[2])]~"and"~.(y_parameter)~"("*.(target_parameters)*")")
    }
    x_parameter_for_plot = bquote(.(x_split_result[1])[.(x_split_result[2])])
    y_parameter_for_plot = y_parameter
  }
  else if ( (ncol(x_split_result)==1) && (ncol(y_split_result)==2) )
  {
    if (is.null(target))
    {
      default_title_for_plot = bquote("Scatter plot of"~.(x_parameter)~"and"~.(y_split_result[1])[.(y_split_result[2])])
    }
    else
    {
      default_title_for_plot = bquote("Scatter plot of"~.(x_parameter)~"and"~.(y_split_result[1])[.(y_split_result[2])]~"("*.(target_parameters)*")")
    }
    x_parameter_for_plot = x_parameter
    y_parameter_for_plot = bquote(.(y_split_result[1])[.(y_split_result[2])])
  }
  else if ( (ncol(x_split_result)==2) && (ncol(y_split_result)==2) )
  {
    if (is.null(target))
    {
      default_title_for_plot = bquote("Scatter plot of"~.(x_split_result[1])[.(x_split_result[2])]~"and"~.(y_split_result[1])[.(y_split_result[2])])
    }
    else
    {
      default_title_for_plot = bquote("Scatter plot of"~.(x_split_result[1])[.(x_split_result[2])]~"and"~.(y_split_result[1])[.(y_split_result[2])]~"("*.(target_parameters)*")")
    }
    x_parameter_for_plot = bquote(.(x_split_result[1])[.(x_split_result[2])])
    y_parameter_for_plot = bquote(.(y_split_result[1])[.(y_split_result[2])])
  }

  plot = plot +
    geom_point(show.legend=FALSE,alpha=alpha) +
    scale_size_area(max_size = max_size) +
    ggplot2::xlab(x_parameter_for_plot) +
    ggplot2::ylab(y_parameter_for_plot)

  if (default_title)
  {
    plot = plot + ggplot2::labs(title=default_title_for_plot)
  }

  if ( (!is.null(xlimits)) && (is.numeric(xlimits)) && (is.vector(xlimits)) )
  {
    plot = plot + ggplot2::xlim(xlimits[1],xlimits[2])
  }

  if ( (!is.null(ylimits)) && (is.numeric(ylimits)) && (is.vector(ylimits)) )
  {
    plot = plot + ylim(ylimits[1],ylimits[2])
  }

  return(plot)
}


#' A histogram of a single variable from a single target.
#'
#' @param output Output from the SMC or EnK algorithm.
#' @param x_parameter The parameter indexed by the x-axis.
#' @param y_parameter The parameter indexed by the y-axis.
#' @param pre_weighting (optional) If TRUE, will ignore particle weights in the histogram. If FALSE, will use the particle weights (defaults to FALSE).
#' @param xlimits (optional) Input of the form c(start,end), which specifies the ends of the x-axis.
#' @param ylimits (optional) Input of the form c(start,end), which specifies the ends of the y-axis.
#' @param default_title (optional) If TRUE, will provide a default title for the figure. If FALSE, no title is used (defaults to FALSE).
#' @param max_size (optional) The maximum size of the points in the plot (default=1).
#' @param alpha (optional) The transparency of the points in the plot (default=0.1).
#' @param duration (optional) The duration of the animation (defaults to producing an animation that uses 10 frames per second).
#' @param save_filename (optional) If specified, the animation will be saved to a gif with this filename (default is not to save).
#' @param save_path (optional) If specified along with save_filename, will save the gif to save_path/save_filename (defaults to working directory).
#' @return A scatter plot in a ggplot figure.
#' @export
animated_scatter_plot = function(output,
                                 x_parameter,
                                 y_parameter,
                                 pre_weighting=FALSE,
                                 xlimits=NULL,
                                 ylimits=NULL,
                                 default_title=FALSE,
                                 max_size=1,
                                 alpha=0.1,
                                 duration=NULL,
                                 save_filename=NULL,
                                 save_path=NULL)
{
  output_to_use = tidyr::pivot_wider(output,names_from=Parameter,values_from=Value)
  p = scatter_plot(output = output_to_use,
                   x_parameter = x_parameter,
                   y_parameter = y_parameter,
                   pre_weighting = pre_weighting,
                   xlimits=xlimits,
                   ylimits=ylimits,
                   default_title=default_title,
                   max_size=max_size,
                   alpha=alpha)

  to_animate = p + gganimate::transition_time(Target)

  nframes = length(unique(output$Target))

  if (is.null(duration))
  {
    animated = animate(to_animate,nframes=nframes)
  }
  else
  {
    animated = animate(to_animate,nframes=nframes,duration=duration)
  }

  if (!is.null(save_filename))
  {
    if (is.null(save_path))
    {
      anim_save(filename=save_filename,animation=animated)
    }
    else
    {
      anim_save(filename=save_filename,animation=animated,path=save_path)
    }
  }

  return(animated)
}
