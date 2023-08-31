#' A histogram of a single variable.
#'
#' @param output Output from the SMC or EnK algorithm.
#' @param parameter The parameter we wish to histogram.
#' @param target (optional) The index of the target we wish to histogram. (default to final target)
#' @param pre_weighting (optional) If TRUE, will ignore particle weights in the histogram. If FALSE, will use the particle weights. (defaults to FALSE)
#' @param bins (optional) Number of bins for the histogram. (default 30)
#' @param xlimits (optional) Input of the form c(start,end), which specifies the ends of the x-axis.
#' @param ylimits (optional) Input of the form c(start,end), which specifies the ends of the y-axis.
#' @param default_title (optional) If TRUE, will provide a default title for the figure. If FALSE, no title is used. (defaults to FALSE)
#' @return A histogram in a ggplot figure.
#' @export
histogram = function(output,
                     parameter,
                     target=NULL,
                     pre_weighting=FALSE,
                     bins=30,
                     xlimits=NULL,
                     ylimits=NULL,
                     default_title=FALSE)
{
  # if (is.null(target))
  # {
  #   target = max(output$Target)
  # }

  if (!is.null(target))
  {
    target_parameters = dplyr::filter(output,Target==target)$TargetParameters[1]
    output_to_use = dplyr::filter(dplyr::filter(output,Target==target),Parameter==parameter)
  }
  else
  {
    output_to_use = dplyr::filter(add_proposed_points(output),Parameter==parameter)
  }

  if ( ("LogWeight" %in% names(output)) && (pre_weighting==FALSE) )
  {
    plot = ggplot2::ggplot(output_to_use, ggplot2::aes(Value, weight = exp(LogWeight)))
  }
  else
  {
    plot = ggplot2::ggplot(output_to_use, ggplot2::aes(Value))
  }

  split_result = stringr::str_split(parameter, "(?<=\\D)(?=\\d)|(?<=\\d)(?=\\D)", n = Inf, simplify = TRUE)
  if ( (ncol(split_result)>2) || (ncol(split_result)==0) )
  {
    stop("For automated captions, parameter needs to be of the form charactersnumber.")
  }
  else if (ncol(split_result)==1)
  {
    parameter_for_plot = parameter
    if (is.null(target))
    {
      default_title_for_plot = bquote("Histogram of the density of"~.(parameter))
    }
    else
    {
      default_title_for_plot = bquote("Histogram of the density of"~.(parameter)~"("*.(target_parameters)*")")
    }
  }
  else
  {
    if (is.null(target))
    {
      default_title_for_plot = bquote("Histogram of the density of"~.(split_result[1])[.(split_result[2])])
    }
    else
    {
      default_title_for_plot = bquote("Histogram of the density of"~.(split_result[1])[.(split_result[2])]~"("*.(target_parameters)*")")
    }
    parameter_for_plot = bquote(.(split_result[1])[.(split_result[2])])
  }

  plot = plot + ggplot2::geom_histogram(bins=bins) +
    ggplot2::xlab(parameter_for_plot) +
    ggplot2::ylab("density")

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

#' An animated histogram of a single variable across targets.
#'
#' @param output Output from the SMC or EnK algorithm.
#' @param parameter The parameter we wish to histogram.
#' @param pre_weighting (optional) If TRUE, will ignore particle weights in the histogram. If FALSE, will use the particle weights. (defaults to FALSE)
#' @param bins (optional) Number of bins for the histogram. (default 30)
#' @param xlimits (optional) Input of the form c(start,end), which specifies the ends of the x-axis.
#' @param ylimits (optional) Input of the form c(start,end), which specifies the ends of the y-axis.
#' @param default_title (optional) If TRUE, will provide a default title for the figure. If FALSE, no title is used. (defaults to FALSE)
#' @param duration (optional) The duration of the animation. (defaults to producing an animation that uses 10 frames per second)
#' @param animate_plot (optiional) If TRUE, will return an animation. If FALSE, returns a gganim object that can be furher modified before animating. (defaults to FALSE)
#' @param save_filename (optional) If specified, the animation will be saved to a gif with this filename. (default is not to save)
#' @param save_path (optional) If specified along with save_filename, will save the gif to save_path/save_filename. (defaults to working directory)
#' @return An animated histogram
#' @export
animated_histogram = function(output,
                              parameter,
                              pre_weighting=FALSE,
                              bins=30,
                              xlimits=NULL,
                              ylimits=NULL,
                              default_title=FALSE,
                              duration=NULL,
                              animate_plot=TRUE,
                              save_filename=NULL,
                              save_path=NULL)
{
  p = histogram(output = output,
                parameter = parameter,
                pre_weighting = pre_weighting,
                bins = bins,
                xlimits = xlimits,
                ylimits = ylimits,
                default_title = default_title)
  to_animate = p + gganimate::transition_manual(Target)

  nframes = length(unique(output$Target))

  if (animate_plot)
  {
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
  else
  {
    if (!is.null(save_filename))
    {
       stop("Cannot save, since plot not animated.")
    }
    else
    {
      return(to_animate)
    }
  }

}
