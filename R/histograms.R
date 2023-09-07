#' A histogram of a single variable.
#'
#' @param output Output from the SMC or EnK algorithm.
#' @param parameter The parameter we wish to histogram.
#' @param dimension (optional) The dimension of the parameter we wish to histogram. (default is 1)
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
                     dimension=1,
                     target=NULL,
                     pre_weighting=FALSE,
                     bins=30,
                     xlimits=NULL,
                     ylimits=NULL,
                     default_title=FALSE)
{

  if (!("Value" %in% names(output)))
  {
    stop('Require tidy data with column "Value" as input to this function.')
  }

  if (!is.null(target) && !(target %in% output$Target))
  {
    stop('target not found in output.')
  }

  # if (is.null(target))
  # {
  #   target = max(output$Target)
  # }

  if (!is.null(target))
  {
    if ("TargetParameters" %in% names(output))
    {
      target_parameters = dplyr::filter(output,Target==target)$TargetParameters[1]
    }
    else
    {
      target_parameters = ""
    }
    output_to_use = dplyr::filter(dplyr::filter(dplyr::filter(output,Target==target),ParameterName==parameter),Dimension==dimension)
  }
  else
  {
    output_to_use = dplyr::filter(dplyr::filter(add_proposed_points(output),ParameterName==parameter),Dimension==dimension)
  }

  if ( ("LogWeight" %in% names(output)) && (pre_weighting==FALSE) )
  {
    plot = ggplot2::ggplot(output_to_use, ggplot2::aes(Value, weight = exp(LogWeight)))
  }
  else
  {
    plot = ggplot2::ggplot(output_to_use, ggplot2::aes(Value))
  }

  if (length(unique(output$Dimension))==1)
  {
    parameter_for_plot = parameter
    if (is.null(target) || (target_parameters=="") )
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
    if (is.null(target) || (target_parameters=="") )
    {
      default_title_for_plot = bquote("Histogram of the density of"~.(parameter)[.(dimension)])
    }
    else
    {
      default_title_for_plot = bquote("Histogram of the density of"~.(parameter)[.(dimension)]~"("*.(target_parameters)*")")
    }
    parameter_for_plot = bquote(.(parameter)[.(dimension)])
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
#' @param dimension (optional) The dimension of the parameter we wish to histogram. (default is 1)
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
                              dimension=1,
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
                dimension = dimension,
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
      animated = gganimate::animate(to_animate,nframes=nframes)
    }
    else
    {
      animated = gganimate::animate(to_animate,nframes=nframes,duration=duration)
    }

    if (!is.null(save_filename))
    {
      if (is.null(save_path))
      {
        gganimate::anim_save(filename=save_filename,animation=animated)
      }
      else
      {
        gganimate::anim_save(filename=save_filename,animation=animated,path=save_path)
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
